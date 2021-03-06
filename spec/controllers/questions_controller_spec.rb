require 'spec_helper'

describe QuestionsController do
  login_admin
  
  def mock_question(stubs={})
    @mock_question ||= mock_model(Question, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all questions as @questions" do
      Question.stub(:all) { [mock_question] }
      get :index
      assigns(:questions).should eq([mock_question])
    end
  end

  describe "GET show" do
    it "assigns the requested question as @question" do
      Question.stub(:find).with("37") { mock_question }
      get :show, :id => "37"
      assigns(:question).should be(mock_question)
    end
  end

  describe "GET new" do
    it "assigns a new question as @question" do
      Question.stub(:new) { mock_question }
      get :new
      assigns(:question).should be(mock_question)
    end
  end

  describe "GET edit" do
    it "assigns the requested question as @question" do
      Question.stub(:find).with("37") { mock_question }
      get :edit, :id => "37"
      assigns(:question).should be(mock_question)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created question as @question" do
        Question.stub(:new).with({'these' => 'params'}) { mock_question(:save => true) }
        post :create, :question => {'these' => 'params'}
        assigns(:question).should be(mock_question)
      end

      it "redirects to the created question" do
        Question.stub(:new) { mock_question(:save => true) }
        post :create, :question => {}
        response.should redirect_to(question_url(mock_question))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved question as @question" do
        Question.stub(:new).with({'these' => 'params'}) { mock_question(:save => false) }
        post :create, :question => {'these' => 'params'}
        assigns(:question).should be(mock_question)
      end

      it "re-renders the 'new' template" do
        Question.stub(:new) { mock_question(:save => false) }
        post :create, :question => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested question" do
        Question.should_receive(:find).with("37") { mock_question }
        mock_question.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :question => {'these' => 'params'}
      end

      it "assigns the requested question as @question" do
        Question.stub(:find) { mock_question(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:question).should be(mock_question)
      end

      it "redirects to the question" do
        Question.stub(:find) { mock_question(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(question_url(mock_question))
      end
    end

    describe "with invalid params" do
      it "assigns the question as @question" do
        Question.stub(:find) { mock_question(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:question).should be(mock_question)
      end

      it "re-renders the 'edit' template" do
        Question.stub(:find) { mock_question(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested question" do
      Question.should_receive(:find).with("37") { mock_question }
      mock_question.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the questions list" do
      Question.stub(:find) { mock_question }
      delete :destroy, :id => "1"
      response.should redirect_to(questions_url)
    end
  end

end
