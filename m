Return-Path: <linux-edac+bounces-1967-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53688992F53
	for <lists+linux-edac@lfdr.de>; Mon,  7 Oct 2024 16:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D031C211AE
	for <lists+linux-edac@lfdr.de>; Mon,  7 Oct 2024 14:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23621DC04C;
	Mon,  7 Oct 2024 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9DS9Ek+"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D161DC042;
	Mon,  7 Oct 2024 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311192; cv=none; b=XO0JQA2aBYMXIEqmba88u1NYqQsCvs0b8E2X0Gpjr/wbZXgnKB/MOrql4Syv1dtgeLhRHO7lW7NaPmbGuE9KxTqsPCFwtv15lXd928m9yIS6AxnQAgpOo67kzuDZcAEHeoIaq4GWBighnAbyfMP/F1W5cM+p06znni9nmhs71ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311192; c=relaxed/simple;
	bh=4u6Ix2MQndl66hwjwUAloKg/zfsVpFbHahOy7+N6lKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gCQAHzLTEtVy1uf4rFHBN3fIgGImB2MVi9la1gyw5TZHxv4E5CQ2xUcP5kK6kSqoyMwjXiOwN63XbfrvWXBwtCxn1gSWK5Mxevhwxei/ZdhDUsH3nKhYgGpWrhd68y+8+sQFb4/doHlWqfSNY3v8TuTFI+CE/spPUvj3arkruHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9DS9Ek+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CB7C4CEC6;
	Mon,  7 Oct 2024 14:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728311192;
	bh=4u6Ix2MQndl66hwjwUAloKg/zfsVpFbHahOy7+N6lKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h9DS9Ek+nUAz7m9v1Ube+mNj+caAzgwHMKQT3vBxOJFJa5lrfyWxJyyXbBCfteoNw
	 e8Jzr9i9LCz3S8PvRIb8kOZREN/nR1FWR4iIGhBydHnRWjCv4EAzhGZNTF9uWhuvOI
	 h5DOEId1Vd8tuIprjOaTxsbNfPhKfi/XW9ZvjvwMSWHqz5SdYH5jabZ3E3Byj5nEWg
	 nRaxNMcu/65YpVvF6449UM7G/Auqn6NeYkDIp6v9FP2k2G6BQtvNqyR9XyZtw1wZcP
	 oZMU1zNCG5xf8AKpJvGfXGIjjNBDxpwYlbcBgXGLpFmbL27GhtxuxWDNI5O+qeQjov
	 vDQOEU7gsx5kw==
From: Bjorn Andersson <andersson@kernel.org>
To: manivannan.sadhasivam@linaro.org,
	bp@alien8.de,
	tony.luck@intel.com,
	mchehab@kernel.org,
	rric@kernel.org,
	konradybcio@kernel.org,
	quic_sibis@quicinc.com,
	abel.vesa@linaro.org,
	Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/qcom: Make irq configuration optional
Date: Mon,  7 Oct 2024 09:26:05 -0500
Message-ID: <172831116174.468342.11751224151895119357.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240903101510.3452734-1-quic_rjendra@quicinc.com>
References: <20240903101510.3452734-1-quic_rjendra@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 03 Sep 2024 15:45:10 +0530, Rajendra Nayak wrote:
> On most modern qualcomm SoCs, the configuration necessary to enable the
> Tag/Data RAM related irqs being propagated to the SoC irq controller is
> already done in firmware (in DSF or 'DDR System Firmware')
> 
> On some like the x1e80100, these registers aren't even accesible to the
> kernel causing a crash when edac device is probed.
> 
> [...]

Applied, thanks!

[1/1] EDAC/qcom: Make irq configuration optional
      commit: 0a97195d2181caced187acd7454464b8e37021d7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

