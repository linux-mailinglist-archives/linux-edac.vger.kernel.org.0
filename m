Return-Path: <linux-edac+bounces-3003-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0F4A2E6E6
	for <lists+linux-edac@lfdr.de>; Mon, 10 Feb 2025 09:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AFE91887618
	for <lists+linux-edac@lfdr.de>; Mon, 10 Feb 2025 08:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CB31C1F02;
	Mon, 10 Feb 2025 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=well-founded.dev header.i=@well-founded.dev header.b="FX1ZYoh9"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D928B1C07C6;
	Mon, 10 Feb 2025 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739177409; cv=none; b=GPCMjQi2MvNgVZNYSCZgQ6fp4fWbQtiMke4Zb2FuJvCtAge5lvwzVGO6zmexlNIDHuyy5YAyAy/1r3sDkdPpByz6Zv8iWm7l24T4cxmxrOTBKo2TPnATV2CVcjWzMsXqN8MN1ycYyzqHhPVFHpgqdgbN9HWXFp1FIVZGBJUWpa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739177409; c=relaxed/simple;
	bh=f6Ib0nJdVnJpt62FRnFEIZ8WmLp0uuE4R2JgmT6UFrw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=GJDJr/tr+QyJSfrVyfhcsDLFUq8jCYkW8nXv9gfz2Xk6VuANzssBVILaHKsS7FMHJkq2WgzBCUgH5uPARZWvytILVZ0A0BjTuA47xmEqRZIdGd+KhVCRUuRHLCWVbVvIXsAX5oP4uq9PCd19MtCMnwBp/6OhKlkhjMC+oQ65z+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=well-founded.dev; spf=pass smtp.mailfrom=well-founded.dev; dkim=pass (2048-bit key) header.d=well-founded.dev header.i=@well-founded.dev header.b=FX1ZYoh9; arc=none smtp.client-ip=185.205.69.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=well-founded.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=well-founded.dev
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id 9ED925E314EA;
	Mon, 10 Feb 2025 09:49:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739177397;
	s=s1; d=well-founded.dev;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
	bh=f6Ib0nJdVnJpt62FRnFEIZ8WmLp0uuE4R2JgmT6UFrw=;
	b=FX1ZYoh9Ws+REgp96LJAyTldp5E5J1dXpb0TY+l5tc4f9L1LT/LWvi05HZkJcry3
	gDnqMiJzN7P810f0SvtdhDFlkzSo7AGbxz/K967m483Y7Yqqne/1jCaLG9DXIFftD7z
	Qu8ET9ClTDU03sxLJBw6tUbA28hUxiHgYln1BoCR0wMs7+ka+GTmEWyaeaoeG7+IsLN
	qDj7V9mH2wVZMfpLwMTS5ENzMhRtiXDu69RhDlYKdYKFaK6TJdGIkdPOAvb0fcSy0Qa
	ziPMBgLlCd+0vMEhkb82e2ClugSJxAuw1/HY9j306b/nmXDuRe2IdGgU5nsZ+CmeMl4
	UwVDWYL8Zg==
Date: Mon, 10 Feb 2025 09:49:57 +0100 (CET)
From: Ramses <ramses@well-founded.dev>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: John <therealgraysky@proton.me>, Linux Edac <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>
Message-ID: <OIj2FiD--F-9@well-founded.dev>
In-Reply-To: <CY8PR11MB7134358940D4625E5196349B89F22@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <OISL8Rv--F-9@well-founded.dev> <CY8PR11MB7134594FDBF7AED80E415AEC89F12@CY8PR11MB7134.namprd11.prod.outlook.com> <OIUifRt--F-9@well-founded.dev> <CY8PR11MB7134358940D4625E5196349B89F22@CY8PR11MB7134.namprd11.prod.outlook.com>
Subject: RE: Flood of edac-related errors since 6.13
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Feb 10, 2025, 09:05 by qiuxu.zhuo@intel.com:

> Hi Ramses,
>
>> From: Ramses <>> ramses@well-founded.dev>> >
>> [...]
>>
>> Thanks for your reply!
>>
>> I recompiled the kernel with that option enabled, and attached the dmesg
>> output to this email. Let me know if I can do anything else to help debug this.
>>
>
> Thanks for helping debug the issue and taking the useful dmesg log.
> From the dmesg log, the ECC error log register of this SoC contained the
> invalid error value ~0, resulting in a flood of invalid error reports in polling mode.
>
> @Ramses & @John,
> Can you please apply the attached fix patch and see whether it fixes the issue?
> Thanks!
>
> -Qiuxu
>

I just booted into a kernel with that patch applied and I'm not getting the errors anymore, so that seems to fix the issue for me indeed!

Thanks a bunch!
Ramses



