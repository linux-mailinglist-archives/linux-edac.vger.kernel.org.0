Return-Path: <linux-edac+bounces-795-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 216FC88AA4C
	for <lists+linux-edac@lfdr.de>; Mon, 25 Mar 2024 17:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DBAD2C40F6
	for <lists+linux-edac@lfdr.de>; Mon, 25 Mar 2024 16:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6B0132819;
	Mon, 25 Mar 2024 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="YU9k3Oez"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1FA823B0
	for <linux-edac@vger.kernel.org>; Mon, 25 Mar 2024 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379849; cv=none; b=RawGWak5zxgwkFmdldDLwtxmhR9Q3LhXux58k9w0xJeBdv0L1cXZWuQ4kXQ3/qvysl5Y6fyNkALE1B6IP4rbROwDcVhzTS60KE1z77lsUQW6LJxzgMIr5RH9a4f7zIG2Red/Ksib9iHYEweMFixnnm28FAq8Rmc9kyE2mY8UHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379849; c=relaxed/simple;
	bh=gPghkh9wzKjrbdKnokKiYukPcrhe8IslWJEi2LXGl4k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmenrf+phs97sLaN+fENIUvmcDD0YkCR6SFcKdG6rVzW4/oDu/FAFPtel4NSGwwticu4iGjV5+vi43VTWlmTclykRJ7IQkqG3tEMAwMoXZI8d4RfD4JPEmDtHV8EcaqLztH8MXcCLR3hbKu7OXSrSDOwSZl3KbR6Ld+JLDEn+Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=YU9k3Oez; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1711379845; x=1711639045;
	bh=gPghkh9wzKjrbdKnokKiYukPcrhe8IslWJEi2LXGl4k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YU9k3OezTlh8cwZGcLRqPI4oC1yVDAy1D8ZjScn4NM1ofpPFeKhtj7cj8gw2Wzluk
	 GTOu8z3+Hytj3eZRM8R6G26QBYCUZZw0RD3tnj4jlg+4w1Nl7SB11dxUFdFOSwKMEP
	 mdOFZNWW6ZrJ+J3hbzG2LrnAYRRh7YQYsaDAC5Cq3xMoCLj1hE35XLKJLv9YcpjN68
	 NqGfgwXKZPKIcULoWrjGkDZ9zc9yZvb+IUvAKcRjOeQS0OnzhJj95WeqKxb0imZ+hI
	 rR6t1i8jjlfOmcD8RCmyS4Q68MYCVUJEnp8kRL8LBiyZxh9jtLFKcP/P9kPPGMiyCz
	 WCaPj/EyGTcDg==
Date: Mon, 25 Mar 2024 15:17:15 +0000
To: "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>
From: A <akira.2020@protonmail.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Fw: kernel 6.9-rc1 fails to compile if debugfs is disabled
Message-ID: <pa4XvmU8F3XrRpJ3Hf0CbvnM8i45sxZGIEhINbgoNP7Yndf8tHfl39xDyTbeBBL70VyK0pIPqXYsuIA0LveV00a9sydrsf6zl_BshQzJYY0=@protonmail.com>
In-Reply-To: <N0Pv2Kh3nXKRyRNwwsJbgOoQ2_TE7fBqHtMUpI4-ijf4qosbq3o_HNCgL02-pr7hgQd6zLqXpJF_MmChCOrzABfX7s6D5lWI3KXk_B2iFB0=@protonmail.com>
References: <N0Pv2Kh3nXKRyRNwwsJbgOoQ2_TE7fBqHtMUpI4-ijf4qosbq3o_HNCgL02-pr7hgQd6zLqXpJF_MmChCOrzABfX7s6D5lWI3KXk_B2iFB0=@protonmail.com>
Feedback-ID: 7267082:user:proton
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

https://bugzilla.kernel.org/show_bug.cgi?id=3D218640

kernel 6.9-rc1 fails to compile if debugfs is disabled (CONFIG_DEBUG_FS):

it fails here:

ERROR: modpost: "ras_get_debugfs_root" [drivers/ras/amd/fmpm.ko] undefined!=
 make[5]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1 make[4=
]: *** [Makefile:1871: modpost] Error 2 make[3]: *** [debian/rules:74: buil=
d-arch] Error 2 dpkg-buildpackage: error: make -f debian/rules binary subpr=
ocess returned exit status 2 make[2]: *** [scripts/Makefile.package:121: bi=
ndeb-pkg] Error 2 make[1]: *** [/ram/linux-6.9-rc1/Makefile:1541: bindeb-pk=
g] Error 2 make: *** [Makefile:240: __sub-make] Error 2`

if i enable debugfs, it compiles without failing.

