Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313601DE939
	for <lists+linux-edac@lfdr.de>; Fri, 22 May 2020 16:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbgEVOpb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 22 May 2020 10:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730172AbgEVOpa (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 22 May 2020 10:45:30 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A284C061A0E;
        Fri, 22 May 2020 07:45:30 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s69so5019075pjb.4;
        Fri, 22 May 2020 07:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rrXdaPjifMrf4XwvQWVex8RQCvnU9ofzUU0gXliR/5E=;
        b=swaw1mtpQgECkgw2Iz/+9mmP15JUnszYKlOMmg86XZ8kzTHq9biLA2qHiPCFXd5Qu+
         DN9s5gOFC5LD5Yo1hdZ2hopDIofoJjcywYu7jnK+jZQKbbkCfsz/fKiaq7QI/pf41Wrb
         y1whQD0ptcQDFDKyfU2HPo/oUdb2FjFzKftplCVMGNZzp1I/8L49zJfDh+7yHK+avfNe
         S+BEe+R8s73fCKUFiD7PcVIouy87a/yV5vnjAXiMQ07ZJzOOSdomJw06DBa6cZl5DTDL
         tdxb+ndlAaOMbCtqje5s6qU/2tO/03L2iXVxFqinSSX5Haz3B7SRxsOFnyKa8aYsDhFD
         j/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rrXdaPjifMrf4XwvQWVex8RQCvnU9ofzUU0gXliR/5E=;
        b=Kx2aHWErfPHanDMfT3IVgWrIaCd0TqaUvNIM4IstOHB0rJpYQN0/+P6i+oAAMSH8PY
         T+plxEo9w5DkwTIIVFtECViGZNIE3ZstkCsZWViTq9RhacSfjF/Kfj7P8CwetL5keF21
         pZ5/RKVJThjkYff0AZISauvVwbmSpo1MLHQWjQhQ0IoYAPM6TAqiRtAouHpe7iPtuzgG
         GpVC0/KdJtqRz+PSWchhqhXq/b0tPRbhCsvzJRCOcb26kK8EVbpIuuQAlLyeLXhgH0z3
         Xg2eVw+5QRpzc8mMt3WVYUw4HZwMhjpLBAAungwV8NNrDy+lUWMCCeWFR33buxYJbEw7
         ciDQ==
X-Gm-Message-State: AOAM532LbhM9CGLAEw810Y0O1dshmnK2tFyCqxYdGBVysTAy7Lt832Ij
        ZaQND/45GsEUsFxnoQSuhwY=
X-Google-Smtp-Source: ABdhPJzdMfDd5MnULGJFuXkjBlAHVDbnewxlMrPCPazeK0Jcg0yY1FZBCYBxdkV3wdi8Y9Y06mcClA==
X-Received: by 2002:a17:90a:ae0d:: with SMTP id t13mr4684628pjq.1.1590158729390;
        Fri, 22 May 2020 07:45:29 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f136sm6852659pfa.59.2020.05.22.07.45.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 May 2020 07:45:28 -0700 (PDT)
Date:   Fri, 22 May 2020 07:45:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Brian Woods <brian.woods@amd.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/amd_nb: add AMD family 17h model 60h PCI IDs
Message-ID: <20200522144527.GA172805@roeck-us.net>
References: <20200510204842.2603-1-amonakov@ispras.ru>
 <20200510204842.2603-2-amonakov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510204842.2603-2-amonakov@ispras.ru>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, May 10, 2020 at 08:48:40PM +0000, Alexander Monakov wrote:
> Add PCI IDs for AMD Renoir (4000-series Ryzen CPUs). This is necessary
> to enable support for temperature sensors via the k10temp module.
> 
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: Yazen Ghannam <yazen.ghannam@amd.com>
> Cc: Brian Woods <brian.woods@amd.com>
> Cc: Clemens Ladisch <clemens@ladisch.de>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-edac@vger.kernel.org
> Acked-by: Yazen Ghannam <yazen.ghannam@amd.com>

For my own reference:

Acked-by: Guenter Roeck <linux@roeck-us.net>

I didn't see a response from any of the x86 maintainers, so this series may
not make it into v5.8. No idea what to do about that.

Guenter

> ---
>  arch/x86/kernel/amd_nb.c | 5 +++++
>  include/linux/pci_ids.h  | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index b6b3297851f3..18f6b7c4bd79 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -18,9 +18,11 @@
>  #define PCI_DEVICE_ID_AMD_17H_ROOT	0x1450
>  #define PCI_DEVICE_ID_AMD_17H_M10H_ROOT	0x15d0
>  #define PCI_DEVICE_ID_AMD_17H_M30H_ROOT	0x1480
> +#define PCI_DEVICE_ID_AMD_17H_M60H_ROOT	0x1630
>  #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
>  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
> +#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
>  #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
>  
> @@ -33,6 +35,7 @@ static const struct pci_device_id amd_root_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_ROOT) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_ROOT) },
>  	{}
>  };
>  
> @@ -50,6 +53,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
> @@ -65,6 +69,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F4) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 1dfc4e1dcb94..3155f5ada02e 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -550,6 +550,7 @@
>  #define PCI_DEVICE_ID_AMD_17H_DF_F3	0x1463
>  #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
>  #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
> +#define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
>  #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
>  #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
