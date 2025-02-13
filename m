Return-Path: <linux-edac+bounces-3074-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0056A34F15
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 21:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B573AB8FF
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 20:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D7324A06F;
	Thu, 13 Feb 2025 20:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hm39E5hf"
X-Original-To: linux-edac@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6910207644;
	Thu, 13 Feb 2025 20:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477446; cv=none; b=Gbm/lS4ytp6x6I3StOgMUCj1UOseXQxPbbnYAhRPmqGxqGONi5y4SxOANj5DDUckLCVrVbDKt1lk7RlYHOb5XvNPP6HzA8ds7QeLWyT2R3hBJoDuvU1P3Q186uAaYjeDv7LOT3KfEuT5F0pTiuQP3EKopqR8zvsNGNIInBQx/eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477446; c=relaxed/simple;
	bh=lQcOiyhfiV06aOvWFmXY01il6wxI1NC4DdpDyGV2sbc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aEUYqMBgLkTDr01EzxgI3BscXXaq5jPOplTlwk9uL33CbKv2+pBRAfjf9XviPx18c/+u9HB9HywPlhgs/t6JSjV6OUlm8w0E20Ud+gmb28VgkdjO7nrNjaH5yIfYy9utImWZ/kAJMfBBe1hkm7M7JvgCFS5a2d7BRloZlxxj0Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hm39E5hf; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739477443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YbGXr3vB0l5AGiB7ZtPkpcgd+VTqz+FSyFsJ9fqPwl8=;
	b=hm39E5hfL1jNajdlurqG9nB9LG90Lwi/OwAGLwRvootb+oRO2R24z+g1xW3tZ9Iztqb01s
	/dwvi2jpNppDGv1yDhxttcWhMXGyEpNcl7IzJdOqbhlz9tb4GVRMiIaztSWYQKSEpj2FKE
	jdk2ILl7NmnD7Um9arywRA1ENadUjLk=
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] EDAC: Use string choice helper functions
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250213174109.GA126857@yaz-khff2.amd.com>
Date: Thu, 13 Feb 2025 21:10:28 +0100
Cc: Borislav Petkov <bp@alien8.de>,
 Tony Luck <tony.luck@intel.com>,
 James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robert Richter <rric@kernel.org>,
 Khuong Dinh <khuong@os.amperecomputing.com>,
 linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <70EC363B-4277-4434-A417-21CBC5345D2D@linux.dev>
References: <20250209215222.52260-2-thorsten.blum@linux.dev>
 <20250213174109.GA126857@yaz-khff2.amd.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
X-Migadu-Flow: FLOW_OUT

On 13. Feb 2025, at 18:41, Yazen Ghannam wrote:
> On Sun, Feb 09, 2025 at 10:52:21PM +0100, Thorsten Blum wrote:
>> Remove hard-coded strings by using the str_enabled_disabled(),
>> str_yes_no(), str_write_read(), and str_plural() helper functions.
>> 
>> Add a space in "All DIMMs support ECC: yes/no" to improve readability.
>> 
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>> drivers/edac/amd64_edac.c | 47 +++++++++++++++++++--------------------
>> drivers/edac/debugfs.c    |  5 ++++-
>> drivers/edac/i5400_edac.c |  3 ++-
>> drivers/edac/i7300_edac.c |  7 +++---
>> drivers/edac/xgene_edac.c | 17 +++++++-------
>> 5 files changed, 42 insertions(+), 37 deletions(-)
>> 
> 
> Please do include a base commit id. This patch doesn't apply to
> ras/edac-for-next but does apply to mainline/master.

Ok. Should I rebase and resubmit or just for next time?

> Is there any effort to make folks aware of these helpers? Maybe an
> addition to checkpatch (as a CHECK/suggestion)?

Not that I'm aware of. However, there is a Coccinelle/coccicheck script
in scripts/coccinelle/api/string_choices.cocci.

Thanks,
Thorsten


