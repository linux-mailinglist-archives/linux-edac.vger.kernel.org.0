Return-Path: <linux-edac+bounces-4478-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03FFB16ABA
	for <lists+linux-edac@lfdr.de>; Thu, 31 Jul 2025 05:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CBFC7B10F7
	for <lists+linux-edac@lfdr.de>; Thu, 31 Jul 2025 03:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6BF23AB85;
	Thu, 31 Jul 2025 03:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9y3v2BE"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ACE374F1;
	Thu, 31 Jul 2025 03:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753931735; cv=none; b=tCedjT6MvcYwgo5lGNOaWRrO7wN+pOtSIxkqZO/xr3Gi33KJYYGoG5aWyPRCfw/efOpQ2yJRUZYQo+G3dEaO3ArC+JgenoJXW/H9ML5yNkaEoqiw/EnuJPZWV7sQmwGOkwbf1wZYYiG72j0cG8oDVlhu+FKsGJIBj7zG9yiNvmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753931735; c=relaxed/simple;
	bh=4ubK10nlNLXRxHgE8dqebb95hXJg0647eX02sXWOHLI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NEphxBWsae732iT4LvBbVSvMq7g3ZuDX9OOUTCzu2YOCAfi0j244KeQf9+ezsyaO98QG5bvOq1RC6UVpzDq5iAZeKO39WCpWLzyOAe/Escrbgn190TkLYASeRomXJ71mqFOgWR/9ePBsiyyWBO2aSzGk8G+0Wd08lfwCpQ0KKoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9y3v2BE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45619d70c72so11519525e9.0;
        Wed, 30 Jul 2025 20:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753931732; x=1754536532; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LacnAABHDrKn9Xt5O+74YJcJtH11ROxmKsUHtO4Nna8=;
        b=B9y3v2BEjDbIv9eOpcCcGfFu7UuvFu+ooYwswy0F7QKPucGrW3tBCLi+BIqQlW/x2s
         hBNs9XO257PBBW7P3MSI7naiEsZHDvJcqv2brRS03wwFq28UK0Oze9aje/jzZ8MF//vr
         kVoTwjJ4TwCu9PQfj3tZMznYZ9NZxLpZg0uumyw4cAINEl/wrageDqqsZHPsC6s0FWKp
         cMkWp6U77E8ioPrIbC0vJsLhSIDNeD6jE1ATpBfPDoj3LoFBLt8EEQ1uIXl44pswcXQB
         lnhOtBrqAj9v8wbYVEvSokGEA324XJOwVYb80CZuTAjTYdAlwNTohK+yGrWxExXiRYS8
         mmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753931732; x=1754536532;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LacnAABHDrKn9Xt5O+74YJcJtH11ROxmKsUHtO4Nna8=;
        b=m+pUAw/1BYDSgg1srjHWlacR0ZYjQfORPMDoSSemMSEc4A3Pw9xqIAAsmusWcwBB51
         D+uB2VA5CsRf3fE8hXdMUhOYq+ftUhiaIErFnhxD56cuw9uyaZ3RHKyd50gJmW5n3H1X
         UO4NA88aC7+AfkV6lxQaZ35aBArapDgJMRKORZjySQlSMswXst0pSt75JUIl9gjlr477
         18yOVlnNkLrwR7GlzizrV5Rg1mxTBHCHb9veIEDaP4l6H0tASzq04aa6wfWKA2CL2cv5
         FckTQt9zklOdCnlW1tWn13tkdKc+Simg06Iuf0MeRzhpBgPaqMHFkzMvGuVMjV1QtRti
         M01A==
X-Forwarded-Encrypted: i=1; AJvYcCVb0Kbsm6uaNd2NO8VppNOJyxtOfnNWwB+uoCHpwnVBovr/oT6mOB/Ds3zXv0Zjb5s5MKU+D2Ve@vger.kernel.org, AJvYcCW8QC3JBjfMfdlwkwIO/UWWpbBMTgK2dtGEmxa6TV+TUobSNqm7JNhBvr9YXxeJV2M9DIyovR0JfTf0eXXm@vger.kernel.org, AJvYcCX8IbtCJ1kR9lb42jtZuUtR1tZZ4GEjT6rd2GOoYJQ/tMK9AkPpWQ91hUqG2ITeKUYsjwBVIWOPauT5@vger.kernel.org
X-Gm-Message-State: AOJu0YxVc/maOWrtaKKJeyIOySOv8dlVJfV/kU1Q91P79Cem9i4Bhww+
	HZou9V3HTgpNf7mt4xNhxAHO72DHdKeVeyD3aLwwqPhDLraSOyjBq+v0
X-Gm-Gg: ASbGncuHIGqEmfX83LUMVHbZ7s+Uo3XfhhhL48y/wpDXTu0qecxQNsbB0ATWvrU+BmB
	N8vhaHngmnX3iVqdzR1QYYpBeS2zt4q/Yru5Q6xBTw3lFMbXi/6mVDpYWdCi9gfrQL4qL4J+Bzx
	r3f95HBeAxal7U01mqudwwm36i78gTgw3LpFIcZ/sX4Eudl7jMUl37kMV261awaF7pl8lVlGnma
	nAklMa8bKISD6agaXxmq1GDOTf4mbFpVkxnE+HndXo9gX6ZJyZ3/B7fOsm8/GZj0UDLMmDCTSgn
	wINSYh4Op0vyAzJQh3xiPmhUFiIWweqXnYCcB6N7G0bKHy1wHU8Nn0sh4aoaOQfUSUotzWVD0YX
	sX4eWRwO0rvk=
X-Google-Smtp-Source: AGHT+IGK+50QwO8pdNFjDIvuoc5BDp7ah4zpf7VTDHZMXZYtttLO72d8HZmZal2SToqmSuZT6FcLZA==
X-Received: by 2002:a05:600c:c093:b0:456:2257:3777 with SMTP id 5b1f17b1804b1-458a20032cfmr2162615e9.4.1753931731316;
        Wed, 30 Jul 2025 20:15:31 -0700 (PDT)
Received: from pc ([165.51.119.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45895377708sm45913035e9.8.2025.07.30.20.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 20:15:30 -0700 (PDT)
Date: Thu, 31 Jul 2025 04:15:27 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>,
	Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] EDAC: altera: Delete an inappropriate dma_free_coherent()
 call in altr_sdr_mc_err_inject_write()
Message-ID: <aIrfzzqh4IzYtDVC@pc>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

`dma_free_coherent()` must only be called if the corresponding
`dma_alloc_coherent()` call has succeeded. Calling it when the allocation
fails leads to undefined behavior.

Add a check to ensure that the memory is only freed when the allocation
was successful.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
Fixes: 71bcada88b0f3 ("edac: altera: Add Altera SDRAM EDAC support")
Cc: Markus Elfring <Markus.Elfring@web.de>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Robert Richter <rric@kernel.org>
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
---
 drivers/edac/altera_edac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index cae52c654a15..7685a8550d4b 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -128,7 +128,6 @@ static ssize_t altr_sdr_mc_err_inject_write(struct file *file,
 
 	ptemp = dma_alloc_coherent(mci->pdev, 16, &dma_handle, GFP_KERNEL);
 	if (!ptemp) {
-		dma_free_coherent(mci->pdev, 16, ptemp, dma_handle);
 		edac_printk(KERN_ERR, EDAC_MC,
 			    "Inject: Buffer Allocation error\n");
 		return -ENOMEM;
-- 
2.43.0


