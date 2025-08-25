Return-Path: <linux-edac+bounces-4649-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F358B33D27
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 12:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7E73BC080
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 10:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6492D1308;
	Mon, 25 Aug 2025 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZUhJnSV"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD86E28C035;
	Mon, 25 Aug 2025 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756118969; cv=none; b=XAmPJEpvAVUoZjKEZolZWCplK9HvnWdZjK84lhwh3mPFkd2AuUIJqeRsCbv4EKf8gYYCeRm9KpEgewxIsOHzrqDVSHubi/xfZRhGm4stbTTxW8JsATmZwJOF91vMzVDcSBSU8GlGmjfk7bsHXVJuvhzNFLGg3JwWNaeE0VK2Zl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756118969; c=relaxed/simple;
	bh=7h7iZiJ+wlDynKLt5pzksYRv8C0Hc5PSFK44OF57HBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YqCElRZzfrABj+dMqwGdLUwDQJoLiySBlEeE7Qx8IOVc17ULVb8sLzaBXN5k8Ci44Klpf3rV9+yMvkrRuzqUuwAgTCumUkbI7Ch3K6Day4/ylGYYs0bw6h1AcaJClHyGK38IlGk/lnOg9NOW4B4YI2aqvWGARrAmIXaspQ2OduA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZUhJnSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82667C4CEED;
	Mon, 25 Aug 2025 10:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756118969;
	bh=7h7iZiJ+wlDynKLt5pzksYRv8C0Hc5PSFK44OF57HBw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=bZUhJnSV4yAV8sWU7yMynIEaF748IqmyeNkvl2164uZf7knrcBGOpYcxLgK+uSzFm
	 910PkIvxRDLXF1BnWsRkgB/oEmr20Bo9bOeYJ3HOhG7t7AuzDcOt/xmSEeB96CAG5E
	 LvfvUnOwK0G5kp/Mwhl4Y38uiCCFdKurUB3NbDlOnA2vjh6k9BCNETXI4NEtNuYyfh
	 CXI7fCfmzrrWRxNmqGRqccRDt8vxsTe2ttt5943f0EudGFFVf7nd9G7VZHCmJtg1c1
	 jMlm2IAqrXux0+JeYXqiPdjiG7OaVe0lLYGVhpvCSbQWZzdvAjWVJlFxA7jfXgd0st
	 8Wh4R5PH7qghw==
Message-ID: <cf83aab6-a9ce-4746-8d88-e66d05d8a866@kernel.org>
Date: Mon, 25 Aug 2025 05:49:27 -0500
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC: altera: Delete an inappropriate dma_free_coherent()
 call in altr_sdr_mc_err_inject_write()
To: Salah Triki <salah.triki@gmail.com>,
 Markus Elfring <Markus.Elfring@web.de>, Borislav Petkov <bp@alien8.de>,
 Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <aIrfzzqh4IzYtDVC@pc>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <aIrfzzqh4IzYtDVC@pc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/25 22:15, Salah Triki wrote:
> `dma_free_coherent()` must only be called if the corresponding
> `dma_alloc_coherent()` call has succeeded. Calling it when the allocation
> fails leads to undefined behavior.
> 
> Add a check to ensure that the memory is only freed when the allocation
> was successful.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> Fixes: 71bcada88b0f3 ("edac: altera: Add Altera SDRAM EDAC support")
> Cc: Markus Elfring <Markus.Elfring@web.de>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Robert Richter <rric@kernel.org>
> Cc: linux-edac@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>   drivers/edac/altera_edac.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index cae52c654a15..7685a8550d4b 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -128,7 +128,6 @@ static ssize_t altr_sdr_mc_err_inject_write(struct file *file,
>   
>   	ptemp = dma_alloc_coherent(mci->pdev, 16, &dma_handle, GFP_KERNEL);
>   	if (!ptemp) {
> -		dma_free_coherent(mci->pdev, 16, ptemp, dma_handle);
>   		edac_printk(KERN_ERR, EDAC_MC,
>   			    "Inject: Buffer Allocation error\n");
>   		return -ENOMEM;


Acked-by: Dinh Nguyen <dinguyen@kernel.org>

