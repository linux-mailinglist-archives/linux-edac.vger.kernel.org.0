Return-Path: <linux-edac+bounces-3935-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E06ABAA55
	for <lists+linux-edac@lfdr.de>; Sat, 17 May 2025 15:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDFED9E3091
	for <lists+linux-edac@lfdr.de>; Sat, 17 May 2025 13:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441BF1EB18A;
	Sat, 17 May 2025 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chiyu.dev header.i=@chiyu.dev header.b="pKdFbt+G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="shC0w21e"
X-Original-To: linux-edac@vger.kernel.org
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA83D17BA6
	for <linux-edac@vger.kernel.org>; Sat, 17 May 2025 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747488224; cv=none; b=cGacyf0I8EulwcrIE+1AdyuJQJNaZaLPRCbjoXoNnzbvV5uyTujj3Wbj4OopZfPqa2XBFWAbRcS+xDo4dWX3c033fOzDxQ+wu8qvplWXs+UsFmgqp+MPLbbuPOC9l9rG+KiY2lD9YCM8531vIzlmL5l1oxG5kFbnc3wbHRIBy4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747488224; c=relaxed/simple;
	bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=TDnc7r6u6OJTKYcYnlSdfmZbhwquryPDmzGThInLxlMLYr8SH24+Fr5Ua2YbPvSuOBtYEhLpZTk92Z/clf7aLnn1EQazvBDSGDB8rDolWtjK6LJY4oQd6RGYQpHMnlt4SPj5cVt1bQiLESz+GDM6wDkNw8GT+YI5DWjkrEzFvKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiyu.dev; spf=pass smtp.mailfrom=chiyu.dev; dkim=pass (2048-bit key) header.d=chiyu.dev header.i=@chiyu.dev header.b=pKdFbt+G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=shC0w21e; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiyu.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chiyu.dev
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 7322F2002AB
	for <linux-edac@vger.kernel.org>; Sat, 17 May 2025 09:23:39 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-11.internal (MEProxy); Sat, 17 May 2025 09:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chiyu.dev; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1747488219; x=1747491819; bh=bIkL3j1SUt
	i+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=; b=pKdFbt+G+rissAlbUlB3I5gLLw
	saFesQo8ddHJ7lF2I77PMsM3+7ag6Ekv1swd0uIckLWzItEXvKE8v28ImKS+Pss6
	pff8fJx95BzS3tSj3dYQJP3t8OwWIAPPa6nV2YYvsZa8LU18DyegP2M8vhE7K/d+
	iOlNeKKUdN45ebzEZVzUvoGWKSxRKjV2WNsQaeo6wDZcjQQVBfvhyF0W6fn+nnkc
	73HYJ74uZNuK/zFKofOk6V8V/AJW5dzFLI8yak4kJEoD+S8yJAakgKXadwitk/Or
	9EglSfS9P3u/S6sg0lnnAnD6P79WuPBHF+y1vn6MSokpSDa1arZYoilLLKSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747488219; x=1747491819; bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrC
	Aj6OvBfk=; b=shC0w21eiAXGG9akZ1LLcBm94B9wgiXz5q+aiAemBR/soRJZw67
	btF69K8LFmFvOfJ++nRbj6aZXfjRvciJQsaJSwLJ4rbSSjcUj2D0DrLQ2ggq8VQf
	9SEJ/8nCoV8ZGjB4adAq7HxpM+ZKAcJ3RNw18F5HNdb/eP9LOxpQjNBLWJorHXos
	kRoj3b7HGDVfH8WIwIdfQFY6FItFbKVXIVBhcZmPa4nBbqpSRjjmXw0JHs1RpHiq
	FioigSzK5xa33SRsMb8LtWNX9PF4rXomeUyvhoxgEVc4QUxSKtopMwENvg540lN9
	/aezw7t1tT/iu43xafmTIGGETzLYTi76jlA==
X-ME-Sender: <xms:240oaH_FALrR0rLce7VvNuHXjl35tgF6eL7EbSLDxTb42ATAYksbSQ>
    <xme:240oaDtNzl7225UXmlLcvwH80-3AGK9F1V2FXlFaG-HJR-O2Phbk14Krrgb-VmhVH
    ZZ-NUOjnF2E3R7ptlo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudehjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucfgmhhpthihuchsuh
    gsjhgvtghtucdluddtmdenucfjughrpefoggffhffvkffutgfgsehtjeertdertddtnecu
    hfhrohhmpeevhhhihihuuceojhhojhhosegthhhihihurdguvghvqeenucggtffrrghtth
    gvrhhnpefhkeeijefhkeelueegkeeifeekheejudegvdeljedvvefhvdeiieevgedvtefg
    feenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjoh
    hjohestghhihihuhdruggvvhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqvggurggtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:240oaFA8_grWJttCZO4UTou9fKN403BOUhzT4eVdvlsPjQ2LRtJkBg>
    <xmx:240oaDf6Eldg33ALZvnL3xEuh8RGgkgFwQZga8eLrOjlpGhSJ8yyCw>
    <xmx:240oaMO32bg5nMT0Z90rTiS5R9i4fWR--U0pkNHqdtmLqAxpUsNJZQ>
    <xmx:240oaFkMd1IFBJYi7wuyG-8ZKOh9wys645PhKv5h6kxZIvP0dp8yfA>
    <xmx:240oaOs9dXraYB050j-br-B-ug1eEvZwEcgFZbj02ilczWDv3EixdHt7>
Feedback-ID: i3ade48f0:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1D2EE780070; Sat, 17 May 2025 09:23:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 17 May 2025 21:23:15 +0800
From: Chiyu <jojo@chiyu.dev>
To: linux-edac@vger.kernel.org
Message-Id: <5c742a1a-8dca-4fda-8816-7d2aa80c39bb@app.fastmail.com>
Subject: 
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

subscribe

