Return-Path: <linux-edac+bounces-4015-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11413AC6812
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 13:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE3E3B7C35
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 11:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEFB27C861;
	Wed, 28 May 2025 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqp36ERQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C655827C173;
	Wed, 28 May 2025 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748430370; cv=none; b=Kn59QJ+Eww85euLQx3CZeqEMvDsF9LGtaHPDem97q5o7Lx9CAvbc+5fh2zutInHKo7tev7It5Hs2DxCiFY3THnwn3EHBgjpbROSUHJuwO0GGCjCIMG7gMqPoSzQlL16foYnOxM/5/3sHjV0dFBHsSyS96JzTgb0vaPHde7d45mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748430370; c=relaxed/simple;
	bh=X9earZIvf1fISCF+OOuXREhJPSrWLukU+8Wu9t5xsk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNm93OjgVcKe6JZg1tteB5PIo9vtTm416oBnjciyGwNUHSTacDBrybdEmtc8T+o7XUN8Zu1OdS8RozcCTOOpXiGtsakE+qKFL1Ge3VMLVH9C8SvrbKLU3mGdxx9uHCtFcmiulSQz0RZpwr59CCc/AUi2E/y4onyHLY86ULnD0AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqp36ERQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58320C4CEEB;
	Wed, 28 May 2025 11:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748430369;
	bh=X9earZIvf1fISCF+OOuXREhJPSrWLukU+8Wu9t5xsk4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uqp36ERQhW7HXtrJ/83Wz5ahSMGyhTL4meva5lRwG50WQCxtiZyB3QF/g5QiYWIPh
	 1y8QvJxATtj+U9I9BuYjAkuYYtJHdPfkbYPzH2OoubncdissCI56G6QqDntzeuMw+f
	 QrWNQAC11w79VBoRnINH+Dd72SureL5gqZYynkKu2mnEpjH3X4HnH5TmgPiQlKsmUN
	 6Zr/HTx2CWxDoTgIprDKsLlX1kVjGLQbqj+8bPhKS2RsswuXsj/eqXnsV/sk8B3yjk
	 +L57iUwLaZoEs8cMiR4wHAJUZvTr4LnHbjBCF1jyjO6fprHZw2rBdl93AzZhrxtSf7
	 +Bfv1elQVNkqw==
Message-ID: <551f297e-d216-4a20-a5d6-cdd2f08949dd@kernel.org>
Date: Wed, 28 May 2025 06:06:06 -0500
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC/altera: Use correct width with writes to INTTEST
 register.
To: Matthew Gerlach <matthew.gerlach@altera.com>, bp@alien8.de,
 tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
 rric@kernel.org, tthayer@opensource.altera.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>, stable@kernel.org
References: <20250527145707.25458-1-matthew.gerlach@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250527145707.25458-1-matthew.gerlach@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/25 09:57, Matthew Gerlach wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> On SoCFPGA platform INTTEST register only supports 16-bit write based on
> the HW design, writing 32-bit to INTTEST register triggers SError to CPU.
> Use 16-bit write for INITTEST register.
> 
> Fixes: c7b4be8db8bc ("EDAC, altera: Add Arria10 OCRAM ECC support")
> Cc: stable@kernel.org
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
>   drivers/edac/altera_edac.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Dinh Nguyen <dinguyen@kernel.org>


