Return-Path: <linux-edac+bounces-2969-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7D1A2B540
	for <lists+linux-edac@lfdr.de>; Thu,  6 Feb 2025 23:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD5EB7A2BEA
	for <lists+linux-edac@lfdr.de>; Thu,  6 Feb 2025 22:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EF922FF35;
	Thu,  6 Feb 2025 22:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=well-founded.dev header.i=@well-founded.dev header.b="H6LMHJev"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0C81F78E6
	for <linux-edac@vger.kernel.org>; Thu,  6 Feb 2025 22:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738881449; cv=none; b=r4k0QBqvHbQeZ0quwcYtVsUPlHPTn1kqt6rPa2+HDX4+sXcHW1X8vxdbgqE2qyPlLi3ACZOdQ1NN7BOWlOJlSH5lhVD2bFHdRmkLbZn9Bnov0kb1RM9/5t0aI07Sq+s71d4vM+FOJscxYpX4FZQzcYAQpBpZHOHuf2dpAujvd1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738881449; c=relaxed/simple;
	bh=rgfFBTD4wlhBXCaQaCGR4CYTKawME6HSZM5gf/Zw5lU=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=ofQi+PBZTaD6UPsxVdM+PWh6Dpj8BnYohzuUpu0XggVRnRRAG/oOywrx2y/0G1boY095pzi1fickY6H7qP1MQG2hzO0D+djkE84n+bTwYIN/PP+gM9AxPALtSD0ey+6k+joYkHohFQU5fQf2FawNGqfdr6pBLdL7PakN+iOnp+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=well-founded.dev; spf=pass smtp.mailfrom=well-founded.dev; dkim=pass (2048-bit key) header.d=well-founded.dev header.i=@well-founded.dev header.b=H6LMHJev; arc=none smtp.client-ip=185.205.69.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=well-founded.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=well-founded.dev
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id 663C15CF8B81
	for <linux-edac@vger.kernel.org>; Thu,  6 Feb 2025 23:28:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738880935;
	s=s1; d=well-founded.dev;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=rgfFBTD4wlhBXCaQaCGR4CYTKawME6HSZM5gf/Zw5lU=;
	b=H6LMHJevZAEAtQWEqPZTdyeySKsJhAZZRBBQdK4pbYgAyUny+Z8KrSi7wD3faiu+
	ZWHCQv3KfPtWVlyakN3ZSUc07C6DCt6jCzxAfCEQGw+sWGl4Cr7t9OYOZAeWlhZ2nQw
	AWepr2uZAOyY2G20WU8688XFf6rDmEFWkVVwfSRLX+UnxjMLzWdYd7ef6iUYZVoIhGZ
	wvHfTO2rJzAwlZKanq/ZWfmKmRcsoIFecSuonKIo8T+OS5It+55oNTCDefpb0xB/jzp
	31TdGynjihh3Y2svha1S4xccEzz76UnUw7WUU+3LbFEMI80JCTr4sgR2K5oVfuY5QYY
	IympYim4Bw==
Date: Thu, 6 Feb 2025 23:28:55 +0100 (CET)
From: Ramses <ramses@well-founded.dev>
To: Linux Edac <linux-edac@vger.kernel.org>
Message-ID: <OISL8Rv--F-9@well-founded.dev>
Subject: Flood of edac-related errors since 6.13
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi

Since 6.13, I get a flood of the following messages in the logs of my intel n100 machine, always with the exact same memory address:

jan 20 12:40:57 beelink kernel: EDAC MC: Ver: 3.0.0
jan 20 12:40:57 beelink kernel: caller igen6_probe+0x1b2/0x83b [igen6_edac] mapping multiple BARs
jan 20 12:40:57 beelink kernel: EDAC MC0: Giving out device to module igen6_edac controller Intel_client_SoC MC#0: DEV 0000:00:00.0 (POLLED)
jan 20 12:40:57 beelink kernel: EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
jan 20 12:40:57 beelink kernel: EDAC igen6 MC0: ADDR 0x7fffffffe0
jan 20 12:40:57 beelink kernel: EDAC igen6: v2.5.1
jan 20 12:40:59 beelink kernel: EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
jan 20 12:40:59 beelink kernel: EDAC igen6 MC0: ADDR 0x7fffffffe0
jan 20 12:41:00 beelink kernel: EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
jan 20 12:41:00 beelink kernel: EDAC igen6 MC0: ADDR 0x7fffffffe0
jan 20 12:41:01 beelink kernel: EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
jan 20 12:41:01 beelink kernel: EDAC igen6 MC0: ADDR 0x7fffffffe0
jan 20 12:41:02 beelink kernel: EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
jan 20 12:41:02 beelink kernel: EDAC igen6 MC0: ADDR 0x7fffffffe0
jan 20 12:41:03 beelink kernel: EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
jan 20 12:41:04 beelink kernel: EDAC igen6 MC0: ADDR 0x7fffffffe0
jan 20 12:41:04 beelink kernel: EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
jan 20 12:41:05 beelink kernel: EDAC igen6 MC0: ADDR 0x7fffffffe0

On previous kernels, I only got this single message right after booting:

jan 20 03:17:45 beelink kernel: EDAC MC: Ver: 3.0.0
jan 20 03:17:45 beelink kernel: caller igen6_probe+0x191/0x810 [igen6_edac] mapping multiple BARs
jan 20 03:17:45 beelink kernel: EDAC MC0: Giving out device to module igen6_edac controller Intel_client_SoC MC#0: DEV 0000:00:00.0 (INTERRUPT)
jan 20 03:17:45 beelink kernel: EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
jan 20 03:17:45 beelink kernel: EDAC igen6 MC0: ADDR 0x7fffffffe0
jan 20 03:17:45 beelink kernel: EDAC igen6: v2.5.1

I assume this change is because of https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.13.1&id=e14232afa94445e03fc3a0291b07a68f3408c120

The system works perfectly fine otherwise and I've had the message at boot for as long as the logs go back (until mid october 2024). I didn't actually notice it before, so I'm only know questioning what's its significance.

Is there a possibility that this is a false positive, or is this definitely an indication that something is wrong with the system's memory and I should replace the DIMM?
I ran memtest for about two hours earlier and it didn't report any failure.

I'd like to hear your thoughts on this.

Cheers,
Ramses


