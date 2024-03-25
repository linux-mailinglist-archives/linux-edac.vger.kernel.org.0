Return-Path: <linux-edac+bounces-794-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E507888AA1F
	for <lists+linux-edac@lfdr.de>; Mon, 25 Mar 2024 17:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22ED31C3794C
	for <lists+linux-edac@lfdr.de>; Mon, 25 Mar 2024 16:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A5B12CDB4;
	Mon, 25 Mar 2024 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="VOHsPPT7"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AABA71756
	for <linux-edac@vger.kernel.org>; Mon, 25 Mar 2024 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379455; cv=none; b=gd0aOls2UOzCgLZ6YZuchqqcX10iNftAR+CeS0cgm0MwCs1Hm4N6yPEY2PRDagiwlo+Vfmm4ni58SU8iqsd3KJw0TNwp2mzDojSYlswssT7HYUVPv4NKns6s5W0P5AY2Ev8LeZkKjlt7uDqNEuDbvgAKyuee6ClVoD7SoFeGsY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379455; c=relaxed/simple;
	bh=dQ67tVVBj3jJzC3Xt9i758lr8XmlPDrlUnK50w56drI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HgUOkVtI09djRAc5FgV3dMr9EPUaCv6i+T20NsEPqtiduqkcuXnrMu6gbGs3iWyKkEsybR2meYC0ln9VnRSsHhFf5n+N5VAUlPmvhS7LtTvbRnhBybU3Ls3lN9N3/jjPZGc3tn5U7ExiCAP6S3hFBLux11iLiK1MtC7Mxe5KTjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=VOHsPPT7; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1711379445; x=1711638645;
	bh=dQ67tVVBj3jJzC3Xt9i758lr8XmlPDrlUnK50w56drI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=VOHsPPT71B7qyMrjY3vVJjKkD/R63MgWo0DZayKCZgyiBhlzyJpoq9NapMsMOE+99
	 +4lD6gRJIPW92DQ9CZFSFv0GEkR/bx5xrE7NmPYK9W8s4PdoXTbESruznKArsPcqE4
	 Mdf7NBg0lD2UIWzwWBT1cm59uflEXRI3h6rNOCwJa39J0qDQxrSMwiFdaBFeqTXEkC
	 XYx9eohDEy3npdsTsGCPpXZaB3Go9JnnDcur7eO+I7FMKN9SSV6bVyHwA31R/IopIX
	 6mCfZn185zdZbEDNtZ3I1XCeMmW1/DzO/fHX/e6D6IbSxhMRTEWl3i9g0+LC+dlxXP
	 MAzTH0/Yti5NQ==
Date: Mon, 25 Mar 2024 15:10:25 +0000
To: "tony.luck@intel.com" <tony.luck@intel.com>, "bp@alien8.de" <bp@alien8.de>
From: A <akira.2020@protonmail.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: kernel 6.9-rc1 fails to compile if debugfs is disabled
Message-ID: <N0Pv2Kh3nXKRyRNwwsJbgOoQ2_TE7fBqHtMUpI4-ijf4qosbq3o_HNCgL02-pr7hgQd6zLqXpJF_MmChCOrzABfX7s6D5lWI3KXk_B2iFB0=@protonmail.com>
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

```ERROR: modpost: "ras_get_debugfs_root" [drivers/ras/amd/fmpm.ko] undefin=
ed!
make[5]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
make[4]: *** [Makefile:1871: modpost] Error 2
make[3]: *** [debian/rules:74: build-arch] Error 2
dpkg-buildpackage: error: make -f debian/rules binary subprocess returned e=
xit status 2
make[2]: *** [scripts/Makefile.package:121: bindeb-pkg] Error 2
make[1]: *** [/ram/linux-6.9-rc1/Makefile:1541: bindeb-pkg] Error 2
make: *** [Makefile:240: __sub-make] Error 2```

if i enable debugfs, it compiles without failing.

