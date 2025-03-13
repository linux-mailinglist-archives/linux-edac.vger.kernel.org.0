Return-Path: <linux-edac+bounces-3358-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0799A5FD9B
	for <lists+linux-edac@lfdr.de>; Thu, 13 Mar 2025 18:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43EE1641D9
	for <lists+linux-edac@lfdr.de>; Thu, 13 Mar 2025 17:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ADE158868;
	Thu, 13 Mar 2025 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reox.at header.i=@reox.at header.b="nkX21Vdp"
X-Original-To: linux-edac@vger.kernel.org
Received: from midgard.reox.at (midgard.reox.at [176.9.78.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5661632C7
	for <linux-edac@vger.kernel.org>; Thu, 13 Mar 2025 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.78.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886495; cv=none; b=eZlJxtli5V12k92W07ST8yGECLqyg0x/giWKEz2WF7Mtw+0uRDGY45e2gi6YsOBX40dO1ppTLg9/swF/jvhHQE2idwCJ3rgDib2KpmW6RXeRKg1YnfsBtmlelO7d126jVpxz0Um8jlEsx1YWl9jVbH5Siw01FaeziivYHo+HqKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886495; c=relaxed/simple;
	bh=MLrR0secfyTXHkQWMOcC/ACob3BInFoABzJQq7sHWXg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=L4tZuO6SFqthgNBhpsZS5XcnMFyWfc3SRIAAp0wQ2aRG255BoD1ZuFZnebalPBKlWER0GeuberWMhQuDXySP7x54rJLdh2dRNho2EZ2p1C5o7m3XHFRq0GCATNzxPcfFHCbvX7/1p8bxtKEktWYEXyyqBLbqfQ09cQOQFhnKjTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=reox.at; spf=pass smtp.mailfrom=reox.at; dkim=pass (2048-bit key) header.d=reox.at header.i=@reox.at header.b=nkX21Vdp; arc=none smtp.client-ip=176.9.78.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=reox.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reox.at
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by midgard.reox.at (Postfix) with ESMTPSA id 4D28F1031BD
	for <linux-edac@vger.kernel.org>; Thu, 13 Mar 2025 18:21:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=reox.at; s=dkim2502;
	t=1741886490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HO498/+Zc1KKL8ZTgA1cS1qqcfRh9qyMTYJ6eWkJ+Tg=;
	b=nkX21Vdp+1gBtzcxKEXC1pLIzzINBntNOYf46o1ndfkSrHXOm8L18HQsrREm2SM3q0bwj8
	QtFDU02Bu0hk0C79H9E/L+mcY1gUkuMeSIBOZiUGKKiOtTwkhvgzxwSvg8PGD4cUgCLZJb
	ufpguOD9eO1xWPcZAa+Lv4x2NwONGvzwMvx45wW6ysQGgrSw+q5TZGLGCHQegstMGwG/fh
	4Mr4DcCJ749pSxkgFH/3KBRcSO8ZE3vO6Gg5PbN5/idET6d15/pzrBwoBBLVnxqDxV57mm
	xuFeZgh+2k7S4VFB41WvAa5K8u8Np3dKWlacyN8Atlb0XveTBpLCXw339VrLCQ==
Message-ID: <27dc093f-ce27-4c71-9e81-786150a040b6@reox.at>
Date: Thu, 13 Mar 2025 18:21:28 +0100
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: linux-edac@vger.kernel.org
Content-Language: en-GB
From: reox <mailinglist@reox.at>
Subject: Memory controller not showing half of the memory?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I hope it is okay to ask such a question on this mailinglist, however 
there is surprisingly little information on this topic (or I'm not deep 
enough in the matter to understand everything correctly...).

I have a server with a ASRockRack B665D4U-1L board. I'm running Debian 
with bookworm-backports kernel 6.12.9-1~bpo12+1.
In the syslog I see the following output of EDAC:
# dmesg | grep -i EDAC
[    1.340448] EDAC MC: Ver: 3.0.0
[    4.705255] EDAC MC0: Giving out device to module amd64_edac 
controller F19h_M70h: DEV 0000:00:18.3 (INTERRUPT)
[    4.705262] EDAC amd64: F19h_M70h detected (node 0).
[    4.705266] EDAC MC: UMC0 chip selects:
[    4.705267] EDAC amd64: MC: 0:     0MB 1:     0MB
[    4.705270] EDAC amd64: MC: 2:  8192MB 3:  8192MB
[    4.705273] EDAC MC: UMC1 chip selects:
[    4.705274] EDAC amd64: MC: 0:     0MB 1:     0MB
[    4.705277] EDAC amd64: MC: 2:  8192MB 3:  8192MB

However, compare this to the real amount of memory (2×32GB):
# lshw -c memory  # shorted
   *-memory
        size: 64GiB
        capabilities: ecc
        configuration: errordetection=multi-bit-ecc
      *-bank:0
           description: [empty]
      *-bank:1
           description: DIMM Synchronous Unbuffered (Unregistered) 4800 
MHz (0.2 ns)
           product: HMCG88MEBEA081N
           vendor: SK Hynix
           size: 32GiB
      *-bank:2
           description: [empty]
      *-bank:3
           description: DIMM Synchronous Unbuffered (Unregistered) 4800 
MHz (0.2 ns)
           product: HMCG88MEBEA081N
           vendor: SK Hynix
           size: 32GiB

I'm a bit confused here... Does EDAC simply miss half of the memory? Is 
this output correct? Or the memory controller not fully implemented / 
bugged in that kernel version (with the bookworm kernel it does not load 
EDAC at all)? Unfortunately I cannot easily run a dev version of the 
kernel on that machine - otherwise I would have probably already done that.

Thanks in advance!
Best,
Sebastian

