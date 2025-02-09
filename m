Return-Path: <linux-edac+bounces-2999-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5087A2DD29
	for <lists+linux-edac@lfdr.de>; Sun,  9 Feb 2025 12:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E651885C68
	for <lists+linux-edac@lfdr.de>; Sun,  9 Feb 2025 11:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D661BD9CE;
	Sun,  9 Feb 2025 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RSI/S2aT"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9374E4594A
	for <linux-edac@vger.kernel.org>; Sun,  9 Feb 2025 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739101842; cv=none; b=fH14QYVEYhcxpxexfVmKUh2v72Ov2En28is3WoEn8Cv1KmRy6uVORrcSb8RqgqvxG+dr1CRe9VclFVq0rFH8Y+OJT/smZN4/Qtbwc/OTimgOOeZrfyibgwpqID92tnYFKtTn9fzbhpM0WrMShOOdX8PO3Gp7vip+w+C1BGGW+c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739101842; c=relaxed/simple;
	bh=ijfC6Mxw8f1SMSeRSz7uTqfuhEdYLAS6QxHuCJlduAc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kGYOjlzvKVWUMsHdcdweq+QGfpoLE2TslFtDQlKkfiKcrL4a+eEcIg6yku1wZFyit1V+2Pk/upQk+LCtmakMWcVjo+06zlARLfY4Dlqn7cmKYc0gagUXMouBloSFWGV/i0wbVZvPUbvzGYajc0Y3HnYZ1XHR7LG2uX1A0Hi3Gi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RSI/S2aT; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1739101832; x=1739361032;
	bh=ACfg6GZrg6bebBmlYm2P9rUAPbedbdRCS93zBlyHKyc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=RSI/S2aTgGPpUcDU/wMdgkaInqeK1bK/d7KeiQQg4ATC87MFAVx4/9OXo6qINd2dO
	 TINUzgmwPL82ykYflVSmBAhAvqbPzEa1wyEIyZL8xqioHwPcqL6aM7iM4h8E5yjIzU
	 o83Dp+rFP9X9ApxlfwFEHCjc4bbpAKQB8NvBD0MOVv/277Q2jufLqsVFGU1nq4LzDG
	 WLs8ggZJ9TBIY70HsdF4Xzb0J9hEcBOUKeUDMBuDnBLTkld6LjE4ypWhgiZQ5tFBb9
	 LrSx+7Zazxub/o8Gf85Fy2kPtpZAqvuVzD+yissilRijzJAPboDVMycTwhaHgrKoVj
	 MYwEyf4A4Wk0A==
Date: Sun, 09 Feb 2025 11:50:25 +0000
To: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
From: John <therealgraysky@proton.me>
Cc: "qiuxu.zhuo@intel.com" <qiuxu.zhuo@intel.com>, "amses@well-founded.dev" <amses@well-founded.dev>
Subject: Re: Flood of edac-related errors since 6.13
Message-ID: <p5YcxOE6M3Ncxpn2-Ia_wCt61EM4LwIiN3LroQvT_-G2jMrFDSOW5k2A9D8UUzD2toGpQBN1eI0sL5dSKnkO8iteZegLoQEj-DwQaMhGx4A=@proton.me>
Feedback-ID: 47473199:user:proton
X-Pm-Message-ID: f2874509c20a1f0ea431ed69ed09bbcc9453cc56
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

In-Reply-To: <CY8PR11MB7134594FDBF7AED80E415AEC89F12@CY8PR11MB7134.namprd11=
.prod.outlook.com>

I have been following this thread as I am similar behavior on a Beelink N10=
0 based system as well.

For me, booting into the 6.13.1 kernel gives the same flood of errors but a=
lso has functional consequences. I get core dumps of /usr/lib/kodi/kodi.bin=
 in libcurl. I do not know if this is related specifically to the EDAC chan=
ges or to something else. If boot into the 6.12.12 kernel instead of the 6.=
13.1 kernel, I get neither the flood of errors nor the coredumps. Please le=
t me know if I can provide any logs to diagnose.

In the meantime, I will compile 6.13.1 with the following reverted and see =
if both improve: https://git.kernel.org/pub/scm/linux/kernel/git/stable/lin=
ux.git/commit/?h=3Dv6.13.1&id=3De14232afa94445e03fc3a0291b07a68f3408c120

Example entries, full journactl output upon request:
...
en6 MC0: HANDLING IBECC MEMORY ERROR
en6 MC0: ADDR 0x7fffffffe0=20
en6 MC0: HANDLING IBECC MEMORY ERROR
en6 MC0: ADDR 0x7fffffffe0=20
JobWorker[17237] general protection fault ip:76a01e02ffe6 sp:769f823fb948 e=
rror:0 in libcurl.so.4.8.0[71fe6,76a01dfc9000+9f000]
p[17254]: Process 1757 (kodi.bin) of user 989 terminated abnormally with si=
gnal 11/SEGV, processing...
rted Process Core Dump (PID 17254/UID 0).
en6 MC0: HANDLING IBECC MEMORY ERROR
p[17255]: [=F0=9F=A1=95] Process 1757 (kodi.bin) of user 989 dumped core.
         =20
          Module [dso] without build-id.
          Module [dso] without build-id.
          Module [dso] without build-id.
          Stack trace of thread 17237:
          #0  0x000076a01e02ffe6 n/a (n/a + 0x0)
          #1  0x000076a01e05320f n/a (n/a + 0x0)
          #2  0x000076a01e04f2a4 n/a (n/a + 0x0)
          #3  0x000076a01e046c7a n/a (n/a + 0x0)
          #4  0x000076a01dfdf080 n/a (n/a + 0x0)
          #5  0x000076a01dfcb7c9 n/a (n/a + 0x0)
          #6  0x000076a01dfd4fee n/a (n/a + 0x0)
          #7  0x000076a01e01f640 n/a (n/a + 0x0)
          #8  0x000076a01e022275 n/a (n/a + 0x0)
          #9  0x000060550d929f1a n/a (n/a + 0x0)
          #10 0x000060550d92abfd n/a (n/a + 0x0)
          #11 0x000060550d94528e n/a (n/a + 0x0)
          #12 0x000060550d9779a4 n/a (n/a + 0x0)
          #13 0x000060550d978aea n/a (n/a + 0x0)
          #14 0x000060550d978d67 n/a (n/a + 0x0)
          #15 0x000060550d0017eb n/a (n/a + 0x0)
          #16 0x000060550d001ed9 n/a (n/a + 0x0)
          #17 0x000060550d304f3c n/a (n/a + 0x0)
          #18 0x000060550d307998 n/a (n/a + 0x0)
          #19 0x000060550d2d8bbc n/a (n/a + 0x0)
          #20 0x000060550d28890d n/a (n/a + 0x0)
          #21 0x000060550cdbaaa9 n/a (n/a + 0x0)
          #22 0x000060550ce7779f n/a (n/a + 0x0)
          #23 0x000060550eaa6b4b n/a (n/a + 0x0)
          #24 0x000060550ce66143 n/a (n/a + 0x0)
          #25 0x000076a01c0e1f74 n/a (n/a + 0x0)
          #26 0x000076a01bea370a n/a (n/a + 0x0)
          #27 0x000076a01bf27aac n/a (n/a + 0x0)
          ELF object binary architecture: AMD x86-64


