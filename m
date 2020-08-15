Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC3C245268
	for <lists+linux-edac@lfdr.de>; Sat, 15 Aug 2020 23:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgHOVuw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 15 Aug 2020 17:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbgHOVus (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 15 Aug 2020 17:50:48 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF42AC03B3CF;
        Sat, 15 Aug 2020 01:42:16 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t15so8501504edq.13;
        Sat, 15 Aug 2020 01:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ewcB7eh6VcMdK2/EFjX3fVLpAyAUfy8E0/JoUkn0HgI=;
        b=LemSqFIat+3vQ38OT9v1LyTatshFL+7G3vYQYbVIX4A5glxOEnMcItzhiTISSLDMlL
         3WDYJisn5kfjBv2GuvpCS9UJWB/bpNPHH5DHUdJRN7AiW80b+zCG94WR0GVNguFvzUCK
         HRI5NIMN34lcNdVL4A8TmIYDbp2CxJB0tqUBlLSMU+3X/fcf330tXUj0KFjaozymLyYd
         bEh0DbZR1tG8Uef7XZJA1NbVfVtV0rI6ZG3tBjAx00L3JQZz9sH25AyuMkfT/1FSJckt
         mIqSMyLdrD7J8iqLa7rCww7TOWSNUHilMtk5kpGMfhrn/BvsHWfBEnsIK1vS4tJY0wV2
         F6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ewcB7eh6VcMdK2/EFjX3fVLpAyAUfy8E0/JoUkn0HgI=;
        b=MQdpLXFcRU2/TQ4BRJJOR2a+ubiNiJ+peQFiT8OYRmLMr03pCnCTjkPDfM9Zd0Ce3o
         WB+thoNMkkhPgdJl4InEZcNXLgONNvO+HT6C++Rxo6zT3rkk/7YXqQRing10lCzxRVPG
         hZIetFfiqFTahcXmyKXnn/nP4vIGZae6zFMsFHRMeS1QbAU0U/9MJQxl/7J6WEzFLVsQ
         DX1UZUHUfSNyH5fr8mZJhw+GN2ZWUpYaT8BzPKT1eeXXd3xAPwHfHWQv0JSr94UMlbwG
         xGwghhIOqODcOIMvPWhKBORHZcPAz4fk5fsHiGKRv1dH54r1reeBO5GL60ncdGuvr4t1
         z1fg==
X-Gm-Message-State: AOAM532a083DccpGsIj4OjlHI3uY35HN/S3XtsrFeg22BMDg1ThZTx1a
        J4zGKWSBh4C0daxhcKMk9uPlOLYEziU=
X-Google-Smtp-Source: ABdhPJzqteyKa596sdV7BbCkNhznlD9P2VIEirR8RoBPNKsb7K65tSiQe+n7ZJf4GiD+XRjihA2KCA==
X-Received: by 2002:aa7:d145:: with SMTP id r5mr5916308edo.323.1597480935312;
        Sat, 15 Aug 2020 01:42:15 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id eb11sm2153780edb.76.2020.08.15.01.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 01:42:14 -0700 (PDT)
Date:   Sat, 15 Aug 2020 10:42:12 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        bp@suse.de, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH 1/2] x86/MCE/AMD, EDAC/mce_amd: Use AMD NodeId for
 Family17h+ DRAM Decode
Message-ID: <20200815084212.GA2444151@gmail.com>
References: <20200814191449.183998-1-Yazen.Ghannam@amd.com>
 <20200814191449.183998-2-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814191449.183998-2-Yazen.Ghannam@amd.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


* Yazen Ghannam <Yazen.Ghannam@amd.com> wrote:

> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> The edac_mce_amd module calls decode_dram_ecc() on AMD Family17h and
> later systems. This function is used in amd64_edac_mod to do
> system-specific decoding for DRAM ECC errors. The function takes a
> "NodeId" as a parameter.
> 
> In AMD documentation, NodeId is used to identify a physical die in a
> system. This can be used to identify a node in the AMD_NB code and also
> it is used with umc_normaddr_to_sysaddr().
> 
> However, the input used for decode_dram_ecc() is currently the NUMA node
> of a logical CPU. In the default configuration, the NUMA node and
> physical die will be equivalent, so this doesn't have an impact. But the
> NUMA node configuration can be adjusted with optional memory
> interleaving schemes. This will cause the NUMA node enumeration to not
> match the physical die enumeration. The mismatch will cause the address
> translation function to fail or report incorrect results.
> 
> Save the "NodeId" as a percpu value during init in AMD MCE code. Export
> a function to return the value which can be used from modules like
> edac_mce_amd.
> 
> Fixes: fbe63acf62f5 ("EDAC, mce_amd: Use cpu_to_node() to find the node ID")
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  arch/x86/include/asm/mce.h    |  2 ++
>  arch/x86/kernel/cpu/mce/amd.c | 11 +++++++++++
>  drivers/edac/mce_amd.c        |  2 +-
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index cf503824529c..92527cc9ed06 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -343,6 +343,8 @@ extern struct smca_bank smca_banks[MAX_NR_BANKS];
>  extern const char *smca_get_long_name(enum smca_bank_types t);
>  extern bool amd_mce_is_memory_error(struct mce *m);
>  
> +extern u8 amd_cpu_to_node(unsigned int cpu);
> +
>  extern int mce_threshold_create_device(unsigned int cpu);
>  extern int mce_threshold_remove_device(unsigned int cpu);
>  
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 99be063fcb1b..524edf81e287 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -202,6 +202,9 @@ static DEFINE_PER_CPU(unsigned int, bank_map);
>  /* Map of banks that have more than MCA_MISC0 available. */
>  static DEFINE_PER_CPU(u32, smca_misc_banks_map);
>  
> +/* CPUID_Fn8000001E_ECX[NodeId] used to identify a physical node/die. */
> +static DEFINE_PER_CPU(u8, node_id);
> +
>  static void amd_threshold_interrupt(void);
>  static void amd_deferred_error_interrupt(void);
>  
> @@ -233,6 +236,12 @@ static void smca_set_misc_banks_map(unsigned int bank, unsigned int cpu)
>  
>  }
>  
> +u8 amd_cpu_to_node(unsigned int cpu)
> +{
> +	return per_cpu(node_id, cpu);
> +}
> +EXPORT_SYMBOL_GPL(amd_cpu_to_node);
> +
>  static void smca_configure(unsigned int bank, unsigned int cpu)
>  {
>  	unsigned int i, hwid_mcatype;
> @@ -240,6 +249,8 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
>  	u32 high, low;
>  	u32 smca_config = MSR_AMD64_SMCA_MCx_CONFIG(bank);
>  
> +	this_cpu_write(node_id, cpuid_ecx(0x8000001e) & 0xFF);

So we already have this magic number used for a similar purpose, in 
amd_get_topology():

                cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);

                node_id  = ecx & 0xff;

Firstly, could we please at least give 0x8000001e a proper symbolic 
name, use it in hygon.c too (which AFAIK is derived from AMD anyway), 
and then use it in these new patches?

Secondly, why not stick node_id into struct cpuinfo_x86, where the MCA 
code can then use it without having to introduce a new percpu data 
structure?

There's also the underlying assumption that there's only ever going to 
be 256 nodes, which limitation I'm sure we'll hear about in a couple 
of years as not being quite enough. ;-)

So less hardcoding and more generalizations please.

Thanks,

	Ingo
