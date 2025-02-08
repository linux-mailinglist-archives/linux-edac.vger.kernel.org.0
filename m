Return-Path: <linux-edac+bounces-2998-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE91CA2D915
	for <lists+linux-edac@lfdr.de>; Sat,  8 Feb 2025 22:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B21BE7A28AE
	for <lists+linux-edac@lfdr.de>; Sat,  8 Feb 2025 21:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA5B1F3BBA;
	Sat,  8 Feb 2025 21:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=truemaisha.co.tz header.i=@truemaisha.co.tz header.b="FDbULu+h"
X-Original-To: linux-edac@vger.kernel.org
Received: from server-598995.kolorio.com (server-598995.kolorio.com [162.241.152.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F391F3B9E
	for <linux-edac@vger.kernel.org>; Sat,  8 Feb 2025 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.241.152.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739051874; cv=none; b=AbaStDwawuOR+wj81wuRjalpHwgdLhvmeTJosEcmmcmDvsmRg6j26G5cISQaG6IwOZ4HbSc8zHA42PJENQCKR0tesF4Q+qQ/zdtLjwnRSDKdY1fCHCMUE5Ua+jp+AB/q56kOP4VbCWt/s1QyX+tbK9tPFd8lumqpNN0NCt7l39s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739051874; c=relaxed/simple;
	bh=gl4+7vNxgV9+JzZtw7EthQ6aGDgi0WVn3wQV/lnKiyo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mMeAvNUmf9PAM+1JcdpkelkjmYA9Wi/vDrUI3Qe+xutCWbrj6/xaCc3W0F4Y6vrkoPSzmKT+YOU7V1urNoEUZMtpO3OMnUIz+cpLbAAdS2PMf069k+4+K5Ze1t2wF4nZwahCM3TFGwSd0JRaM3yRKhI+it31zw3lSvhVov/NXhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=truemaisha.co.tz; spf=pass smtp.mailfrom=truemaisha.co.tz; dkim=pass (2048-bit key) header.d=truemaisha.co.tz header.i=@truemaisha.co.tz header.b=FDbULu+h; arc=none smtp.client-ip=162.241.152.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=truemaisha.co.tz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=truemaisha.co.tz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=truemaisha.co.tz; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gl4+7vNxgV9+JzZtw7EthQ6aGDgi0WVn3wQV/lnKiyo=; b=FDbULu+hwLJKnYEXKCQIA7cEDI
	yoNblGhjtSoXbA3Ng24P3gdsXqSuVI6V+MdwBycbjCCVmA0hOkJqh7IYqkIwjNCzp84Ii+7vk5xZP
	1bH6Eajp8DNgrRSFhW9V9FiLDAkqOTmCFqv7wHN5PSTr4/CsCNpyQdLMDmuaq8PPgqlmQJZprBhv6
	GWHfGwXguea//3lkZL0uqlJi9tc7m+2VBs7a/NFcWQy12ROlyAhZK09E/dIb0SjYGu+tT1VTw1sYR
	WIDGBihUA/HmGS+M7X/oPjxlMUu0TQDZafWK713EkNmZ/PGLm8KfD/83DG5OXUM67sUtcMiZmLeCC
	aQ9Q8ckw==;
Received: from [74.208.124.33] (port=59317 helo=truemaisha.co.tz)
	by server-598995.kolorio.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <chrispinerick@truemaisha.co.tz>)
	id 1tgsph-0004sT-16
	for linux-edac@vger.kernel.org;
	Sat, 08 Feb 2025 15:57:50 -0600
Reply-To: dsong@aa4financialservice.com
From: David Song <chrispinerick@truemaisha.co.tz>
To: linux-edac@vger.kernel.org
Subject: Re: The business loan- 
Date: 08 Feb 2025 21:57:51 +0000
Message-ID: <20250208210541.9BE699D703129566@truemaisha.co.tz>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server-598995.kolorio.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - truemaisha.co.tz
X-Get-Message-Sender-Via: server-598995.kolorio.com: authenticated_id: chrispinerick@truemaisha.co.tz
X-Authenticated-Sender: server-598995.kolorio.com: chrispinerick@truemaisha.co.tz
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hello,

My name is David Song, at AA4 FS, we are a consultancy and
brokerage Firm specializing in Growth Financial Loan and joint
partnership venture. We specialize in investments in all Private
and public sectors in a broad range of areas within our Financial
Investment Services.

 We are experts in financial and operational management, due
diligence and capital planning in all markets and industries. Our
Investors wish to invest in any viable Project presented by your
Management after reviews on your Business Project Presentation
Plan.

 We look forward to your Swift response. We also offer commission
to consultants and brokers for any partnership referrals.

 Regards,
David Song
Senior Broker

AA4 Financial Services
13 Wonersh Way, Cheam,
Sutton, Surrey, SM2 7LX
Email: dsong@aa4financialservice.com


