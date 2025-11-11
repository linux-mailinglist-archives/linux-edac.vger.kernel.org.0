Return-Path: <linux-edac+bounces-5432-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 913C2C4D85F
	for <lists+linux-edac@lfdr.de>; Tue, 11 Nov 2025 12:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 435C74F2911
	for <lists+linux-edac@lfdr.de>; Tue, 11 Nov 2025 11:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2652FD7B1;
	Tue, 11 Nov 2025 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jL8GcXI1"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FCF2FBE02;
	Tue, 11 Nov 2025 11:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861614; cv=none; b=qz7woJVkUh2EoanLsQPvIPEL6I5Ud3nHMEOv4lTKftyLnrsrO8eDEEsSBZfOXsBeFLvertLNanO5C0YPEaU4bui+2X6JWeLSMxUfmc7RH7+JRG4paqY55ekSe/OFvFORVVsxjOpzb1ga1cuOPx/8p8/lfxy0hv8066y2UMJOTuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861614; c=relaxed/simple;
	bh=rbNJbwQaBcRf4KNiq9G/qg/S5qDVdWHZCk623jvQNEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cAOCe69wduJljLVbAi5rr3xx0801qXtiwgy8dD9Ni1jQXlzWYwXkUDPnSwtAlxYA+kacJkaET59dfGRdd05v7k/Q2cnf92kBy0IiG0lvFAVjlCeTfB9wv4oBoPOXu1ayrRhs2lSr3wYgtmfdKr8GTScH0iVjRorsA7AC9O5LuGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jL8GcXI1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A76C116D0;
	Tue, 11 Nov 2025 11:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762861614;
	bh=rbNJbwQaBcRf4KNiq9G/qg/S5qDVdWHZCk623jvQNEs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jL8GcXI1ItZe32CT+KBn/kcGiBK5XTxl56y0yOPgqp1VB5uPY3YVkQzBqryEom4Us
	 6Zwh3BEgMVaSc8DUKiUAUELh4nvvhMOmCVTWZ+cOnEpbQcRuv9WkyU70Uk4XEnxLlB
	 xiWDE5OqCwBfefOHM45rBf+DAahj7rPIakb7ufLw8LXDYSMe3dzCtP1vlHFpWNP35h
	 EOBj9Ht2Jld0TP5FzfhsLwhUY0qTyinhetCtip7kJXUQAKd3XLAY8ZVbxyBxhCAQDJ
	 jbnmpYMlQXOFD8r1i5+LCNL4sPnNZpeKWR2yTnMEz8qp3dUyp4Ozv1BCQw5VX7zArq
	 q6mwlVg36qVaA==
Message-ID: <13bf4434-13a1-4db0-8bcf-4c52edaa68f3@kernel.org>
Date: Tue, 11 Nov 2025 05:46:51 -0600
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] EDAC/altera: Use INTTEST register for Ethernet and USB
 SBE injection
To: niravkumarlaxmidas.rabara@altera.com, bp@alien8.de, tony.luck@intel.com
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251111081333.1279635-1-niravkumarlaxmidas.rabara@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20251111081333.1279635-1-niravkumarlaxmidas.rabara@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/11/25 02:13, niravkumarlaxmidas.rabara@altera.com wrote:
> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> 
> The current single-bit error injection mechanism flips bits directly in
> ECC RAM by performing write and read operations. When the ECC RAM is
> actively used by the Ethernet or USB controller, this approach sometimes
> trigger a false double-bit error.
> 
> Switch both Ethernet and USB EDAC devices to use the INTTEST register
> (altr_edac_a10_device_inject_fops) for single-bit error injection,
> similar to the existing double-bit error injection method.
> 
> Fixes: 064acbd4f4ab ("EDAC, altera: Add Stratix10 peripheral support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> ---
> 
> v2 changes:
>   - Add missing Cc tag
> 
> v1 link:
> https://lore.kernel.org/all/20251101051723.917688-1-niravkumarlaxmidas.rabara@altera.com/
> 
>   drivers/edac/altera_edac.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index 103b2c2eba2a..5c5d4585d8ae 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c

Acked-by: Dinh Nguyen <dinguyen@kernel.org>

