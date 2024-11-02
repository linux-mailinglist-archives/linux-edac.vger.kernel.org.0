Return-Path: <linux-edac+bounces-2411-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DD69BA0C9
	for <lists+linux-edac@lfdr.de>; Sat,  2 Nov 2024 15:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E903B21523
	for <lists+linux-edac@lfdr.de>; Sat,  2 Nov 2024 14:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F5E2B9AA;
	Sat,  2 Nov 2024 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pthNs/uu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J11FLQmH"
X-Original-To: linux-edac@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843C633F9;
	Sat,  2 Nov 2024 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730557901; cv=none; b=N3xaxlVLWBtKNC0rgJgE5kUC1T7khyCxuLWgfRgR7AD7vxRVjxDpq1q3jvQXv0smtOOBlemqgXQpGgQBYNT3M3aH1+4YhYzkU+JRFybtSrg/blWjIxtIxFzMChrPJazgZbIRlrxXkzAeOZrN/2W5EYbNrAR5Ope3jzzeCgPdUUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730557901; c=relaxed/simple;
	bh=5iLbbCUPJf7YmLWvEZ+kwQ7ai3Iwuq6rQ7PwTyzgAcA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YO/ztFRkNMBvgX0cPIgnyrqAtPxuaH6cjkbHlb3+jE1WK+QxFn4MGj5obFtmFEGkD8uqtMKRKihme2b/y+WJda/divY5KKOrrVQA4Y9JguU0HYFxJgdC9/Kt5ZbA0FSF1MxQC8YPhWcg/MFNbe0wSzeE0qshMxkw9tmGw9ER3EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pthNs/uu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J11FLQmH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730557897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PCLizQatx+g8t9hN+L5hFbXz2rz5UqRrLPXl6IsKvoM=;
	b=pthNs/uuqNd3tM3se1N4bQJnRZIXBPYRkdC17EFua2G7LrGHVhEFtJ0+pbk9QKgRpPTjO4
	nY1q8k8wgv2O6/BGz2Gcat4tEJ0CFv4bKj54JFZsWDI+AAY+6jTmW/SbZP/LqoDbIszfII
	ZiqXbpL16r1P6if/cvgq7uV3F1hrKH6e4aGYX5UaQw31MDH2s8cGDFGWGMfjsAWirVTZ8i
	nOxcfq6EgN1vZXR0L9PApnPCqCRo8nQzPjuGNWqEdyFreF+7kkBrdDS3CHF/vTENyh4xuL
	Zmu1jUWAg20uJIxHwasVJ9aJFWzM4IAtE0cvq7iijZ1+ioTiLFoM8wUWUYcPMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730557897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PCLizQatx+g8t9hN+L5hFbXz2rz5UqRrLPXl6IsKvoM=;
	b=J11FLQmHCEs0xhp0CTQ3tg80WIZqqqHL4OvKNnZ+J5NCuhbe4cB0RqB08JejYBUBKMB8uP
	NJvR2YSWQK5Ua5DQ==
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, tony.luck@intel.com, bp@alien8.de
Cc: dave.hansen@linux.intel.com, mingo@redhat.com, hpa@zytor.com,
 x86@kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 qiuxu.zhuo@intel.com
Subject: Re: [PATCH 05/10] x86/mce/genpool: Make mce_gen_pool_create()
 return explicit error codes
In-Reply-To: <20241010153202.30876-6-qiuxu.zhuo@intel.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241010153202.30876-6-qiuxu.zhuo@intel.com>
Date: Sat, 02 Nov 2024 15:31:36 +0100
Message-ID: <87ed3tr9kn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 10 2024 at 23:31, Qiuxu Zhuo wrote:

> Make mce_gen_pool_create() return explicit error codes for better
> readability.

What's the point?

All error paths including gen_pool_add() return -ENOMEM.

The call site just cares about success or fail.

So this can simply be converted to bool and return true on success and
false otherwise.

Thanks,

        tglx


