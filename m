Return-Path: <linux-edac+bounces-3755-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265B2A9DA86
	for <lists+linux-edac@lfdr.de>; Sat, 26 Apr 2025 14:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733265A268F
	for <lists+linux-edac@lfdr.de>; Sat, 26 Apr 2025 12:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC4722A1E4;
	Sat, 26 Apr 2025 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCQe1cI/"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE2379FD;
	Sat, 26 Apr 2025 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745669875; cv=none; b=c+dvSfrIfwW82bDZdaDxRTP8Nx3NAxWqtl2OGny8shZM3wnkkNkuLo3pZIjUdyKstxj0loWh1WN0wb00DLbaPRfOgln55yRtKgQMMtv6UNcgizbUenjH8pOyRZviZtxXfR/8gFSWhO+6NfLWHxomcjc6ur/6iFg8F7PNKYMU494=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745669875; c=relaxed/simple;
	bh=a2gnhEhVAxzz17+YbFBxFlSD7XTaw+gmqqKOR1M44uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JOzkTGxVwIKa5VCm2Xdpd2cpWr2TDWvBl8CTfqLZzj4hi5A0cxwPvAuUZsrRNxUMf9xU/nuxMi+Qzjl5BSctQE3AtMMt0sZdyt1kD3c9Y3pMwnQgvJnr2dvQAVqCxKKyQNu0mBLGdjKqzL/kdbHBUjOCgAOeBXF/+WggpJLJXNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCQe1cI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C20C4CEE2;
	Sat, 26 Apr 2025 12:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745669874;
	bh=a2gnhEhVAxzz17+YbFBxFlSD7XTaw+gmqqKOR1M44uY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sCQe1cI/CJSk09ymCyaTuvk4+wk1+CtOk54v/1axGfNvd0sTb8IXMKQVBxp8P1+O0
	 OyxshcTMECq9dli7MDgJG8tVaOZp5dsVGW1Oc4WLU4eWnJFZNN8eH4qAGtA+K4u60Q
	 g0TNtS3mfoRSpXdjXhRfO46GNz8zW2vv/I83oUl13dkciSs7saLEHjND2/MBBfstJ8
	 zuSsppzY+upDQRecRJtzlodPeCsc7zf5cS/za6F+LR9XaH1KdWAZ/EBEumkdlbE/Hk
	 diVVR8pbblgNtVRHHUlTGWry4MRwhfkLPJAp9GOBVZtEfTZ3wiKFunx/CSek9fJtaN
	 t+FMDsceBU7rg==
Message-ID: <055220fe-c153-4023-8890-5545693d2122@kernel.org>
Date: Sat, 26 Apr 2025 07:17:52 -0500
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] EDAC/altera: fix cut and paste error
To: Matthew Gerlach <matthew.gerlach@altera.com>, bp@alien8.de,
 tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
 rric@kernel.org, tthayer@opensource.altera.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>, stable@kernel.org
References: <20250425142640.33125-1-matthew.gerlach@altera.com>
 <20250425142640.33125-2-matthew.gerlach@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250425142640.33125-2-matthew.gerlach@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/25 09:26, Matthew Gerlach wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>
> 
> Test correct structure member, ecc_cecnt_offset, before using it.
> 
> Fixes: 73bcc942f427 ("EDAC, altera: Add Arria10 EDAC support")
> Cc: stable@kernel.org
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
> v3:
>   - Use 12 digit HASH for Fixes: tag.
> 
> v2:
>   - Improve commit message.
>   - Add Fixes: and Cc: tags.
> ---

Acked-by: Dinh Nguyen <dinguyen@kernel.org>


