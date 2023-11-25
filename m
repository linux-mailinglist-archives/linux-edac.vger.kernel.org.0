Return-Path: <linux-edac+bounces-94-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074417F8E13
	for <lists+linux-edac@lfdr.de>; Sat, 25 Nov 2023 20:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B1ECB20FBD
	for <lists+linux-edac@lfdr.de>; Sat, 25 Nov 2023 19:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B052FE00;
	Sat, 25 Nov 2023 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlXf1p1j"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916DC129;
	Sat, 25 Nov 2023 11:37:47 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so520467a12.0;
        Sat, 25 Nov 2023 11:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700941066; x=1701545866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lDIBxA9kD5zfBqSmoblE0Q36en0y2Rsc1kRyQf2RpvI=;
        b=WlXf1p1jlk3AMMhP2i9eFj7NsDJBibJt6WmdME16HTYcuM0NroEVBPoqQlqyxKEF/1
         p3LFb3/5pQaejmLc90eNvFN49iD2KnO2ep4je11g/Bc3PQHR63Onr1CBjaS4lAl6ws/Z
         JXhc5xrVSnbVOaXPee5Fq//1TanZST6UbS1HkLXbW/+N5YF3Pqj7S+q3ZQUW3hcuJczP
         MjeSxzridUlB2clrWojSgrGK+2qct5gjYmRrQJFvm+dsZsvvqJT12BRsAmxAOGqbDyIU
         EICYy4RWxMfIru5r5nVaxedUZTUybX78OePh9Yv++uWTsCYGOfF3HbL7vGLjDqA+ANwf
         LSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700941066; x=1701545866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDIBxA9kD5zfBqSmoblE0Q36en0y2Rsc1kRyQf2RpvI=;
        b=NaHJKarIqhuNvI2KB61nP56r5elBgSa0WVCOz5j3h+xtZrqi7loTrF48apSGxvMrTA
         23xCKBZ8/klitmJrFCUMPbUgrVfPs4Q3vXjSBvpUNhWk14BTNykPwXaBydk14hSYVO9a
         1a7OkPdmTs+p3GEqmjQrmPIUQMIErpRREPzXG85Bpim0PhFW11kEQhARDH1tFhfv2kWG
         Necd6XoHyoALhWF83YjMHz8SH1nmWfzDwvdSToV5+xyIgMzNHcCnexVEOLNLfA0CbSB3
         eKMgf+Qnf5y0eSKWQw4wsXZ7of7dCAUvXklg9eiHapLTN/ZBPP5D2KKgmWXcFP9RNlQ2
         5e7Q==
X-Gm-Message-State: AOJu0YwLyvahz6DHCiygH+TwCZyeaHR/FNNpFdWzPUzeus6ZP3/HTdFy
	HdgsNqvuFKvGQuKEkzGOC8c=
X-Google-Smtp-Source: AGHT+IENJDWPrj2AQtMqCZGty34ui9ZnqiqL7t6IzyBzgSeVGbG1NqW6Cf2dyMipIYQ2x4bWMQ504g==
X-Received: by 2002:a05:6a00:1514:b0:6cb:d24b:894c with SMTP id q20-20020a056a00151400b006cbd24b894cmr8555929pfu.2.1700941066463;
        Sat, 25 Nov 2023 11:37:46 -0800 (PST)
Received: from [192.168.0.152] ([103.75.161.210])
        by smtp.gmail.com with ESMTPSA id x23-20020aa793b7000000b006cb638ba1aasm4610588pff.49.2023.11.25.11.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 11:37:46 -0800 (PST)
Message-ID: <af53864a-39df-4530-bf3f-5277be8f0d4d@gmail.com>
Date: Sun, 26 Nov 2023 01:07:42 +0530
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver : edac : Fix warning using plain integer as NULL
Content-Language: en-US
To: tony.luck@intel.com, qiuxu.zhuo@intel.com, bp@alien8.de,
 james.morse@arm.com, mchehab@kernel.org, rric@kernel.org
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20231109212157.1454726-1-singhabhinav9051571833@gmail.com>
From: Abhinav Singh <singhabhinav9051571833@gmail.com>
In-Reply-To: <20231109212157.1454726-1-singhabhinav9051571833@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/23 02:51, Abhinav Singh wrote:
> Sparse static analysis tools generate a warning with this message
> "Using plain integer as NULL pointer". In this case this warning is
> being shown because we are trying to initialize  pointer to NULL using
> integer value 0.
> 
> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
> ---
>   drivers/edac/i7core_edac.c |  2 +-
>   drivers/edac/sb_edac.c     | 10 +++++-----
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
> index 23d25724bae4..08bf20c60111 100644
> --- a/drivers/edac/i7core_edac.c
> +++ b/drivers/edac/i7core_edac.c
> @@ -376,7 +376,7 @@ static const struct pci_id_table pci_dev_table[] = {
>   	PCI_ID_TABLE_ENTRY(pci_dev_descr_i7core_nehalem),
>   	PCI_ID_TABLE_ENTRY(pci_dev_descr_lynnfield),
>   	PCI_ID_TABLE_ENTRY(pci_dev_descr_i7core_westmere),
> -	{0,}			/* 0 terminated list. */
> +	{NULL,}			/* 0 terminated list. */
>   };
>   
>   /*
> diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
> index 0c779a0326b6..a3f50a66de33 100644
> --- a/drivers/edac/sb_edac.c
> +++ b/drivers/edac/sb_edac.c
> @@ -439,7 +439,7 @@ static const struct pci_id_descr pci_dev_descr_sbridge[] = {
>   
>   static const struct pci_id_table pci_dev_descr_sbridge_table[] = {
>   	PCI_ID_TABLE_ENTRY(pci_dev_descr_sbridge, ARRAY_SIZE(pci_dev_descr_sbridge), 1, SANDY_BRIDGE),
> -	{0,}			/* 0 terminated list. */
> +	{NULL,}			/* 0 terminated list. */
>   };
>   
>   /* This changes depending if 1HA or 2HA:
> @@ -505,7 +505,7 @@ static const struct pci_id_descr pci_dev_descr_ibridge[] = {
>   
>   static const struct pci_id_table pci_dev_descr_ibridge_table[] = {
>   	PCI_ID_TABLE_ENTRY(pci_dev_descr_ibridge, 12, 2, IVY_BRIDGE),
> -	{0,}			/* 0 terminated list. */
> +	{NULL,}			/* 0 terminated list. */
>   };
>   
>   /* Haswell support */
> @@ -576,7 +576,7 @@ static const struct pci_id_descr pci_dev_descr_haswell[] = {
>   
>   static const struct pci_id_table pci_dev_descr_haswell_table[] = {
>   	PCI_ID_TABLE_ENTRY(pci_dev_descr_haswell, 13, 2, HASWELL),
> -	{0,}			/* 0 terminated list. */
> +	{NULL,}			/* 0 terminated list. */
>   };
>   
>   /* Knight's Landing Support */
> @@ -620,7 +620,7 @@ static const struct pci_id_descr pci_dev_descr_knl[] = {
>   
>   static const struct pci_id_table pci_dev_descr_knl_table[] = {
>   	PCI_ID_TABLE_ENTRY(pci_dev_descr_knl, ARRAY_SIZE(pci_dev_descr_knl), 1, KNIGHTS_LANDING),
> -	{0,}
> +	{NULL,}
>   };
>   
>   /*
> @@ -686,7 +686,7 @@ static const struct pci_id_descr pci_dev_descr_broadwell[] = {
>   
>   static const struct pci_id_table pci_dev_descr_broadwell_table[] = {
>   	PCI_ID_TABLE_ENTRY(pci_dev_descr_broadwell, 10, 2, BROADWELL),
> -	{0,}			/* 0 terminated list. */
> +	{NULL,}			/* 0 terminated list. */
>   };
>   
>   
Hello maintainers, any reviews or comments

Thank You,
Abhinav Singh

