Return-Path: <linux-edac+bounces-1151-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C0E8D3C1E
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2024 18:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3EF1F25209
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2024 16:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D477A1836CE;
	Wed, 29 May 2024 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="X5b6b1au";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g9imyt2P"
X-Original-To: linux-edac@vger.kernel.org
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AA8181B91;
	Wed, 29 May 2024 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716999728; cv=none; b=Hp1/cHH04w4dKDZYzy2lmWxPKnKXglw0iLU98BQFiQs0vPRRZelYve7wKh1ri38MJ/EJRG0z+jCicj6j2pFspBEKgAyaOylSquASHJK9G1ZV4sWnJDY+JERjfStuxtDqdN3rybkbYNxRCnPv9KxXN3JQuRbx1vlBwUImdRMPdSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716999728; c=relaxed/simple;
	bh=EDIXZx3IPrf64VApzbWtoRjjXMxwcz0IlemDKC5Su68=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=dBfv3CCcE6ykCxKFAtV13BC0SZXvodKb6bnjCEKcXYqdoGv0tsep4TtAixxtWsZNYBY8MBPjXYmehC4VjC8Bf3QpSr+fCvM938QVb5SnWttsugWwfhB7TTcAhl0dZ/znMY8vZtcMvyIc8g4pcCJrolL9Zi/bGfswYcEHeKZ4ZDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=X5b6b1au; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g9imyt2P; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id AC4EA1800141;
	Wed, 29 May 2024 12:22:05 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 29 May 2024 12:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1716999725; x=1717086125; bh=o9RjPAa9HE
	pajKmAsJmm5sKFuh+vn34PA2zIfnayZfc=; b=X5b6b1auT1fWZ1GdeIXIsQFsaF
	ndeJr4MGDDAW8792Fq4GZBaNDE9Qwei/7M2MS9Zz285fvgcG0VAPy2qcoP1kVUdH
	Xvp1ww1n9ugpkau2ObDrSw5P41RtudOXqlpG9J6Uz3hGC07UF3VFxaaI1uWQaM0l
	bUupqB3nkYlCwZu5PI2nhjBHtR3fklZPPAFKEIvixQcEJGjqq3FSaOLQBbxQwT6o
	ZkdTLQ3ElzuqTqDwew+XTDPKvxeBk9sEJb3rz1EGzp0eb66U2GxgTHfN9roocaDW
	xdSvvzO1sBWrpEAJbGxYeTwWOwUo5hk2rgLR/6u02W4uqQen6TveWRNlIFsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716999725; x=1717086125; bh=o9RjPAa9HEpajKmAsJmm5sKFuh+v
	n34PA2zIfnayZfc=; b=g9imyt2PGyu3k6F1VPXdxZnB8CvqDXOt0FxCbpnVx1Oo
	tillRsdjwIMlJ5N2NwiBjd4qkjIlPQ45KnaFo+f6IhOyvKd4T08W8emLzraCaUFY
	0muyjOklxh87atj51BwcMc4fTWBY1F9K5QfphuKNA0nkUKzvDgL1yVz986R+YAJd
	Bd2cExyPmLtqsng2m2BZxP4U3wg/b06iGfXV19L5opcj4bvKIB9b2sSi1nEf2bHM
	sMhRUTcOH6lKz78esv+q5NgyGmU6Kkv1gzp/202yN2r3muJDiHkwG3FZSQddRJgl
	MfHJQwTMBvFXS0CA5yayJqm00nf349ef5Pkz7gTSUw==
X-ME-Sender: <xms:LFZXZpsTXHND3Djz2oIbexavmcpiK0wsnuqMWDMQP3gB0uVKz1hk1w>
    <xme:LFZXZie3q5xp3lJAPOdM6Crys_Is4mmvMqI7_2bQJxNRGs12kWjEe7OZjJVNVKJQh
    Y_9EXo9Ic-wmN1gdos>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:LFZXZsxd_pyAZSUM5-lLhGhr7-ZKL-gKbzCFGL2IWNx_eccN-1ZkJw>
    <xmx:LFZXZgOkhgVwPjjb_wId8S9atEEEcbuUMnn-RFAfSE5gXgM7wcsD7g>
    <xmx:LFZXZp9LtlqWLDnzRcuRX6oBT--X146cQQOZQMLIYqcBYcNLZf0haQ>
    <xmx:LFZXZgWpCYF6vD_rKOSN0FrsC4Ko4OFNIOUVyz7Ewx-UIl6JL_bJ3g>
    <xmx:LVZXZgUHoIv5-m6Bh6J9yfp6TEIP2s2n9Ys0CdILjx-WlRtty16nRyKS>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id BEBD6B6008D; Wed, 29 May 2024 12:22:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e526fbec-5fc6-4778-b46d-608744a4d7f6@app.fastmail.com>
In-Reply-To: 
 <SJ1PR11MB60838B76940188104D57E53FFCF22@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240529095132.1929397-1-arnd@kernel.org>
 <SJ1PR11MB60838B76940188104D57E53FFCF22@SJ1PR11MB6083.namprd11.prod.outlook.com>
Date: Wed, 29 May 2024 18:21:44 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Tony Luck" <tony.luck@intel.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Borislav Petkov" <bp@alien8.de>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "James Morse" <james.morse@arm.com>,
 "Mauro Carvalho Chehab" <mchehab@kernel.org>,
 "Robert Richter" <rric@kernel.org>, "Marvin Lin" <milkfafa@gmail.com>,
 "Shubhrajyoti Datta" <shubhrajyoti.datta@amd.com>,
 "Sai Krishna Potthuri" <sai.krishna.potthuri@amd.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC, i10nm: make skx_common.o a separate module
Content-Type: text/plain

On Wed, May 29, 2024, at 18:14, Luck, Tony wrote:
>> Linking an object file into multiple modules causes a warning:
>>
>> scripts/Makefile.build:236: drivers/edac/Makefile: skx_common.o is added to multiple modules: i10nm_edac skx_edac
>
> In this case there is no practical problem from this double link. The 
> two modules created: skx_edac.ko and i10nm_edac.ko
> are mutually exclusive. A system may load neither, either, but not both 
> (enforced by the x86_match_cpu() check in each
> modules init function).

One of the problems here is that each compilation unit implicitly
knows the name of the module it gets linked into, via the
KBUILD_MODNAME macro. If it gets linked twice, the macro is
wrong for at least one of the two, and this can lead to
incorrect printk formats and other macro expansions using
that as an identifier.

A particularly bad case happens when one of the two is
built-in while the other one is a loadable module. In
this case, the module infrastructure assumes it's always
built-in, which can mess up e.g. __exit annotations and
THIS_MODULE references.

     Arnd

