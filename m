Return-Path: <linux-edac+bounces-5314-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B39C30541
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 10:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065493AB32B
	for <lists+linux-edac@lfdr.de>; Tue,  4 Nov 2025 09:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FCC2D062E;
	Tue,  4 Nov 2025 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWYajnxB"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30A92D12EF;
	Tue,  4 Nov 2025 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248828; cv=none; b=elxmupSfiiJlvWrodsZI3qznm6iaNbYgvqpRV70+FPSljhTXU9eIGnt5vV/IfP7HEb+ibnGybmL4HyXO85AowLKmepe/JPlNzHfArAcnTprbM9PWTRt1cCWIsCyJ1A40+E8LRhxh/NyQWG81fh5MXoq4rRpuxVdgn28T9rO3lus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248828; c=relaxed/simple;
	bh=W8xOsfIs+FLN84wwq7ugJWJ2PpWVMPpw+o5LSPIz4yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unDeEM4IiHMnUWobOEjCwbH+IHuKYObiVTKJzc1/4fKb6uTvNG1ak9+9ezbLH6hn2pFpmOof1AgmVNkMVQIAhPn8HSOIClO1jWeHHYNrten/XfOCSos4/0+Lr1yDaz0qJuaRn1tCecz9Dj+m9+49SE1d50XVbuFYGBI7ESAiQuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWYajnxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5A0C4CEF7;
	Tue,  4 Nov 2025 09:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762248827;
	bh=W8xOsfIs+FLN84wwq7ugJWJ2PpWVMPpw+o5LSPIz4yc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kWYajnxBp06uW/Fbs79kSGCpFkkJissFIjAueVxphZmrNwxcidb952mL7jDfxfeEM
	 XJMcOLucCMvioxcRc3UuMhSygFZ8zEozO1os6GUUCJTgBUum6a2NOM8ycJBo5ZvRTh
	 q4qL41VoYqesUXOIgnoz2xmQhohvfe/NCRDL5wM4+B6SkjG2MOumm3OV53+g5VcYQv
	 Ey0IZONjjtkNzP6gyl/+Tqlhe8/uPT5DclF3GHsppa3KQJ96pMpc05bLsXTfHlyR57
	 BgWJpdf/tcA4ihoVrCkv2IXq5pvCtMkA2PH3WTW6bAMPkRrAoKbNn6oZhbldp6jDjX
	 lisGYz+Rk0wDg==
Message-ID: <1b316667-470b-4e1a-9c18-e42571e4769c@kernel.org>
Date: Tue, 4 Nov 2025 10:33:39 +0100
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] x86/mm: support memory-failure on 32-bits with
 SPARSEMEM
To: Xie Yuanbin <xieyuanbin1@huawei.com>, david@redhat.com,
 dave.hansen@intel.com, bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, linmiaohe@huawei.com,
 nao.horiguchi@gmail.com, luto@kernel.org, peterz@infradead.org,
 tony.luck@intel.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-edac@vger.kernel.org, will@kernel.org, liaohua4@huawei.com,
 lilinjie8@huawei.com
References: <20251104072306.100738-1-xieyuanbin1@huawei.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251104072306.100738-1-xieyuanbin1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.11.25 08:23, Xie Yuanbin wrote:
> Memory bit flips are among the most common hardware errors in the server
> and embedded fields, many hardware components have memory verification
> mechanisms, for example ECC. When an error is detected, some hardware or
> architectures report the information to software (OS/BIOS), for example,
> the MCE (Machine Check Exception) on x86.
> 
> Common errors include CE (Correctable Errors) and UE (Uncorrectable
> Errors). When the kernel receives memory error information, if it has the
> memory-failure feature, it can better handle memory errors without reboot.
> For example, kernel can attempt to offline the affected memory by
> migrating it or killing the process. Therefore, this feature is widely
> used in servers and embedded fields.

This is a pretty generic description of MCEs.

I think what we are missing is: who runs 32bit OSes on MCE-capable 
hardware (or VMs?) and needs this to work.

What's the use case?

-- 
Cheers

David

