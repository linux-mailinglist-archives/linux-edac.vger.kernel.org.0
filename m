Return-Path: <linux-edac+bounces-4053-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0ECAC9C2E
	for <lists+linux-edac@lfdr.de>; Sat, 31 May 2025 20:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B47817F8F7
	for <lists+linux-edac@lfdr.de>; Sat, 31 May 2025 18:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5E14D8CE;
	Sat, 31 May 2025 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gamyjiES"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90C328371
	for <linux-edac@vger.kernel.org>; Sat, 31 May 2025 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748714703; cv=none; b=JR356LEXZsdio1NOHSsPwBJk/6+sJTMYWhi1uRbr2FKm5rejO+ws6bYxE2Fx6UPmoZNqaO+fXA8qH3rMoIeoKdaBGiH2s8dTGDuSdWW8SI6+HtWUT4uW+IqIjJI0su2gPkiqo4RsC5vMXRLHOivP7y0SU2zHTqv55DO24UzkFAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748714703; c=relaxed/simple;
	bh=jaIXDXigKl469dEo19Yrnh5EaHbBVaXROAQvXLyOInk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOLkQcKfWaAZoVCxs77HetZwlChQn0zt27AQVbvCUMZZ5V/SY4oeDKjLOF4FLvpUurP3nJfotoXIk1MrnJM6eGulAMb11Yu7vmwyjyOyzt9jqm8ji6NWsfo0cTKEzRDVKhZuMAmSs+qfkC6xcnmNU4F5bOLD+mKPex3qpG+K3y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gamyjiES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2B9C4CEE3;
	Sat, 31 May 2025 18:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748714703;
	bh=jaIXDXigKl469dEo19Yrnh5EaHbBVaXROAQvXLyOInk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gamyjiESz1Fk9yX4ci4aBon7HDul/Ow0N9HQ8oMgCQ3Gul1QEbeQrWo7h3S5BBxXD
	 3LJRwVyz7mfTJvY3uOax8sePM6QwaGGgOwNzwbMP/TPh575SY94Y96hM0dIE8pfEAt
	 JyOo7nEXL/jk8ID7rGZeIkC9Ro42JSVAPW87ZOmnXefwc2s/oP/vqQsOSJgUuGe8ue
	 Yz1ralXBkYXtnTaYzQg/mi4NRj5A7inXOADnrrCUcpnpZTyuLIdzvANyuo4IjWtQU8
	 dSXFxlSLb79DvyqXRBkTi2dFIdIsr/eNjqq5AD7L+HbdxdTmp05P4dK2zFS2A3RwRt
	 /npSc00p95rzA==
Date: Sat, 31 May 2025 20:04:58 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>, tony.luck@intel.com,
	x86@kernel.org, linux-edac@vger.kernel.org, wanghai38@huawei.com,
	bobo.shaobowang@huawei.com
Subject: Re: [RFC PATCH] x86/mce/inject: Add sanity check in inject_mce()
Message-ID: <aDtEyl5A36zRyV7B@gmail.com>
References: <20250529033256.31554-1-wangxiongfeng2@huawei.com>
 <20250529094534.GAaDgsvhdl-BrzlM0J@fat_crate.local>
 <aDq6cecrsKYrwra2@gmail.com>
 <20250531091746.GAaDrJOuUlQyfRjgv3@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250531091746.GAaDrJOuUlQyfRjgv3@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Sat, May 31, 2025 at 10:14:41AM +0200, Ingo Molnar wrote:
> > Uhm, avoiding a hard kernel crash in case of a tooling or human error:
> 
> Do you know what this tool is about?
> 
> It is supposed to cause crashes, among others.

What tool? If you mean syzkaller, then it is very much not supposed to 
crash on a correctly functioning kernel. If it causes a crash, then the 
proper response is to fix the crash.

Or if you mean the MCE-injection interface, that's not supposed to 
trigger avoidable crashes either, it's an injection facility for 
testing purposes:

          Provide support for injecting machine checks for testing purposes.

It's really simple really:

- If the kernel unnecessarily locks up on the receipt of a 
  hardware-generated MCE then that's a kernel bug that
  should be fixed.

- If the kernel unnecessarily locks up on the receipt of a 
  software-generated MCE then that's a kernel bug that
  should be fixed.

TL;DR, this is not an acceptable kernel response:

> > [  306.335489][ T3298] mce: CPUs not responding to MCE broadcast (may include false positives): 1-3
> > [  306.336332][ T3298] Kernel panic - not syncing: Timeout: Not all CPUs entered broadcast exception handler
> > [  306.337786][ T3298] Kernel Offset: 0x17400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Thanks,

	Ingo

