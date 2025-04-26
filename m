Return-Path: <linux-edac+bounces-3756-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F32A9DA88
	for <lists+linux-edac@lfdr.de>; Sat, 26 Apr 2025 14:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC935A26B7
	for <lists+linux-edac@lfdr.de>; Sat, 26 Apr 2025 12:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F3422B8AA;
	Sat, 26 Apr 2025 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idggl069"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4803C1A256E;
	Sat, 26 Apr 2025 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745669899; cv=none; b=H6hm461zqLm2XGIXYS8b9jL7KIS5pnFgemSv++MMOQ7dpY32NzXJPrRLZgopuduP+8eBuipNLfiiO+VgB3pf6yYszNZZbGIgZ8vAG5PR5yFzLOJxv4eLy5lxBP5MbNUtJKGZ/AsN3wkCCLgr6IBkzZL7EWxxsQlG81w51CwBoRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745669899; c=relaxed/simple;
	bh=o+3gL4mGSlALhkmpiNHYPhddXvIJMNEZyE5BZLTtHBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXUhgg+jrfsXLf59cSV0lTnMCq/IvNDD4DvCOG6rM5JJCJnQ3gS9RXgKNSqmvomqVoWoMpFhPlL4KEPxw5XGEZLfpRsozK7A3rpTAnK/9ltaOv43C2Vy//xVym8Cjfo6v5ueqRDY+H54CZKHUIEMwalvi4q99DsIUTFKiudPyj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idggl069; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CD9C4CEE2;
	Sat, 26 Apr 2025 12:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745669897;
	bh=o+3gL4mGSlALhkmpiNHYPhddXvIJMNEZyE5BZLTtHBg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=idggl0698YIsSmrJ744O7ijrto7AockdIYv9fcDnG/fKxIr2ukmV9gX6sE6txuQlm
	 mEPHMlQ9WQuAlcshDtcfVV9GqB1cdDgTGtnkjcUtCUE2eTSTBGQ8zYpiZkKB2wh4mu
	 TczsKHgkKW3jIAE/YI1oZ2XBsNJYapzZnW63247wZPOkPDL3o9lPqV3zkYpjjSjiEh
	 iNFx7ApZXY8HSy0W1xxWHsisJP+Ik18qM9tdI+sBOBzmmk937+7AV4PLr/lc5HAU98
	 YO6J0BJTk0QpFQRgBRKjrOLfQuxs8gnd1uhGxUlkSjVAaYCiOdsWbDNafkGfm5C7D+
	 RTN/OI6l/bH9Q==
Message-ID: <dbe55e65-15f3-4768-9156-519154f87274@kernel.org>
Date: Sat, 26 Apr 2025 07:18:16 -0500
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] EDAC/altera: Set DDR and SDMMC interrupt mask
 before registration
To: Matthew Gerlach <matthew.gerlach@altera.com>, bp@alien8.de,
 tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
 rric@kernel.org, tthayer@opensource.altera.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>, stable@kernel.org
References: <20250425142640.33125-1-matthew.gerlach@altera.com>
 <20250425142640.33125-3-matthew.gerlach@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250425142640.33125-3-matthew.gerlach@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/25 09:26, Matthew Gerlach wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>
> 
> Mask DDR and SDMMC in probe function to avoid spurious irq before
> registration.  Removed invalid register write to system manager.
> 
> Fixes: 1166fde93d5b ("EDAC, altera: Add Arria10 ECC memory init functions")
> Cc: stable@kernel.org
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
> v3:
>   - Use 12 digit HASH for Fixes: tag.
> 
> v2:
>   - Add Fixes: and Cc: tags.

Acked-by: Dinh Nguyen <dinguyen@kernel.org>


