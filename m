Return-Path: <linux-edac+bounces-4566-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82421B2340C
	for <lists+linux-edac@lfdr.de>; Tue, 12 Aug 2025 20:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D9E3AA49A
	for <lists+linux-edac@lfdr.de>; Tue, 12 Aug 2025 18:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3432EF652;
	Tue, 12 Aug 2025 18:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="LP8EWMdQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBE81EF38C;
	Tue, 12 Aug 2025 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023473; cv=none; b=QUABkWByuk9uFOpJP4ASnzNGSlND3VIEiLK+lI+guVqzUg4D4TgMo5ifWspdqg7H47vsU4JkcDAxjoroW0at7uUmdjY5ebl4SV79X7bhit5VPYuOsfMrBAfVF1I85ctx7rVrtYdc4O6EOWqBpsja/R3S0rAzHSWLND/TD0yEFPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023473; c=relaxed/simple;
	bh=VYEh2U+HozjubzC2hkNUllG0x1AMyWF47DIDyoFwjKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eTu0cMPsqyDAIHVbiNm3Mmv/0fCQaJSOOKesHNQh7R2l0qMr2rS7/NEM+EuRp4W9rNcqMkTUeZkw+mrJ6Ox9jKNB/o+xJ3ObnRNFLdDMTMxqjTFT5RY6DGKtx7t3k79cSGBqmMilY+QDa389G1X/wDf1Fgwdl/KK2Wh6/EF4Ipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=LP8EWMdQ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9338C40AD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755023464; bh=Pc+Sy5s3UxH6RxvOOBqHHymFZRkVWMaCuaEcOu5B17k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LP8EWMdQ19YVqACm/1vbJGHvip6CRo5BsdM0VdGFyoguvggipnqqXgExOE+Nj1UUQ
	 8lco9QQiyrH2CgbV1W1sMs4O8nhI+aVaVxmJVVYQvuHD2US2ZEh1gG02b1wr+rZEyF
	 uwZUPBl7/E4lCKzQnO+7tvR9MNCHU96JKbugULYrv7nBH68UxMVx3rJvFtN9isHlHO
	 yg20a5+vR8pSzbJoiuXrjGCG5dJRaYu9M3QRgJRAPt37Czo/iNflOgNrWKszmI5V9W
	 zo6H1uTYoSpmsFEscxPMzHud2gUa3maKtLzznnAHtf0okuZqcDrZkW7/lG8SL7dEvM
	 xedj3Y9uurjdw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9338C40AD9;
	Tue, 12 Aug 2025 18:31:04 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>
Cc: EDAC Mailing List <linux-edac@vger.kernel.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, "David S. Miller" <davem@davemloft.net>, Ignacio
 Encinas Rubio <ignacio@iencinas.com>, Marco Elver <elver@google.com>, Shuah
 Khan <skhan@linuxfoundation.org>, Donald Hunter <donald.hunter@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Jan Stancek <jstancek@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
 stern@rowland.harvard.edu, Breno Leitao <leitao@debian.org>, Randy Dunlap
 <rdunlap@infradead.org>, Simon Horman <horms@kernel.org>
Subject: Re: [GIT PULL for v6.17-rc2] add a generic yaml parser integrated
 with Netlink specs generation
In-Reply-To: <20250812113329.356c93c2@foz.lan>
References: <20250812113329.356c93c2@foz.lan>
Date: Tue, 12 Aug 2025 12:31:03 -0600
Message-ID: <87h5ycfl3s.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Hi Jon/Jakub,
>
> In case you both prefer to merge from a stable tag, please pull from:
>
> 	git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-docs.git docs/v6.17-1
>
> For:
>
> - An YAML parser Sphinx plugin, integrated with Netlink YAML doc
>   parser.

OK, I have done that.  I will note that it adds a warning:

> Documentation/networking/netlink_spec/index.rst: WARNING: document isn't included in any toctree

...it might be nice to get that straightened out.

Thanks,

jon

