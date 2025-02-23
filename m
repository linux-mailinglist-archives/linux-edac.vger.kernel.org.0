Return-Path: <linux-edac+bounces-3187-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B55A411EC
	for <lists+linux-edac@lfdr.de>; Sun, 23 Feb 2025 22:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEEB11731A5
	for <lists+linux-edac@lfdr.de>; Sun, 23 Feb 2025 21:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FB222D4DE;
	Sun, 23 Feb 2025 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CCgdk2iz"
X-Original-To: linux-edac@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CDF13E40F
	for <linux-edac@vger.kernel.org>; Sun, 23 Feb 2025 21:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740346139; cv=none; b=XmcAb05ElgKtKUktivQrkY2xvoVyA1yVi2L6eDsl2Aaachaf7pLkgM3MT+hPPaL9QU4yJaqLenyVKgfKKEFjk5ryw9PNjv1pR7LWszHrxpGCfciWCx85c1hKa11DpDZlMLRsiiaSkeWSk5AZi55z6nameUCW2HjcKqvWFWcHYSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740346139; c=relaxed/simple;
	bh=JtaTB5MyesAfN5Ao1peRL8vn4mOO81wdD/J4hI6XzUA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QhJzknmNAIR3hCgeiQsr+Ih7PRl2AohRRBpaZb6EzAkulgvBzv3lYuzswf5zBWq6lkdDuna6WdadufJn9HohDhnL2Kh7O4VWeaQiCBxO2ttZkKTJjG/luirzBtoxp/nbwWEEfl+ADMY230wUej5Mnh4SxmfE7fCghh4bGQTmwzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CCgdk2iz; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740346135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z4auzQ4cPT9LXAom6WZiiYroFVlhrvvlhqqKjp9VmN4=;
	b=CCgdk2izkMM3IRr/o1Toa4dGV9chJxmFCi+4W8ko7eOPfzATeXev3BNtu8HYjWmhWDeKmP
	h9a4j+T5SmO7lCYhwL1WtxsOIrCxLZhmi4Es0fC5JI7onvCresOFtb1eDd53D07TftynnG
	D4tN8R1Ozl+nBDd0l38RbIeCSmCNVrg=
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] EDAC: Use string choice helper functions
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250213210510.GA212119@yaz-khff2.amd.com>
Date: Sun, 23 Feb 2025 22:28:41 +0100
Cc: Borislav Petkov <bp@alien8.de>,
 Tony Luck <tony.luck@intel.com>,
 James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robert Richter <rric@kernel.org>,
 Khuong Dinh <khuong@os.amperecomputing.com>,
 linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <B4626391-D626-4539-93B3-9FB00F0EB713@linux.dev>
References: <20250209215222.52260-2-thorsten.blum@linux.dev>
 <20250213174109.GA126857@yaz-khff2.amd.com>
 <70EC363B-4277-4434-A417-21CBC5345D2D@linux.dev>
 <20250213210510.GA212119@yaz-khff2.amd.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
X-Migadu-Flow: FLOW_OUT

On 13. Feb 2025, at 22:05, Yazen Ghannam wrote:
> On Thu, Feb 13, 2025 at 09:10:28PM +0100, Thorsten Blum wrote:
>> On 13. Feb 2025, at 18:41, Yazen Ghannam wrote:
>>> On Sun, Feb 09, 2025 at 10:52:21PM +0100, Thorsten Blum wrote:
>>>> Remove hard-coded strings by using the str_enabled_disabled(),
>>>> str_yes_no(), str_write_read(), and str_plural() helper functions.
>>>> 
>>>> Add a space in "All DIMMs support ECC: yes/no" to improve readability.
>>>> 
>>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>>> ---
>>>> drivers/edac/amd64_edac.c | 47 +++++++++++++++++++--------------------
>>>> drivers/edac/debugfs.c    |  5 ++++-
>>>> drivers/edac/i5400_edac.c |  3 ++-
>>>> drivers/edac/i7300_edac.c |  7 +++---
>>>> drivers/edac/xgene_edac.c | 17 +++++++-------
>>>> 5 files changed, 42 insertions(+), 37 deletions(-)
>>>> 
>>> 
>>> Please do include a base commit id. This patch doesn't apply to
>>> ras/edac-for-next but does apply to mainline/master.
>> 
>> Ok. Should I rebase and resubmit or just for next time?
> 
> Just for next time I think.

This actually applies to ras/edac-for-next for me.

I just resend the patch with a base commit id anyway.

Thanks,
Thorsten


