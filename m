Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D3E7A15A7
	for <lists+linux-edac@lfdr.de>; Fri, 15 Sep 2023 07:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjIOFrW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 15 Sep 2023 01:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjIOFrW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 15 Sep 2023 01:47:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61D12716;
        Thu, 14 Sep 2023 22:47:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE0BC433B7;
        Fri, 15 Sep 2023 05:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694756837;
        bh=RyPR2NkOFcffhMr5xddvC27sEYDMrJaqGqZTUScQkPA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PcvjwDYx9G5f5Q1qxmIfIx5D0ne1wz4esF+c5nMP3hE41d6nNonhJxXX4/PUPMnzt
         6IFVF+L5cUwGSpdXGC9UnPrlhotCcgfse/rpTnTcuP+ptih8GLpBYauZqloFgw4mKm
         1BJ4h9wpYsZDVo/JkDqFS86S8QepQGmMcduIrPgKI9p+ayQKVK5++KZEbJZg+++hRi
         APvnDLOLgHFa9QzULX+SIhe2v+5k6OYtaDDMPz3MGCP43ZqWapGyedZSR/31ZKtcxY
         zc2AZBJQYwAAfcCSy28d4Vinr1VmiJGRwpjQCASK4NeItrige3SaZGkefwxAZMm0JB
         fOjUjO2NE9U5Q==
Date:   Fri, 15 Sep 2023 14:47:10 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Xin Li <xin3.li@intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-hyperv@vger.kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, pbonzini@redhat.com, seanjc@google.com,
        peterz@infradead.org, jgross@suse.com, ravi.v.shankar@intel.com,
        mhiramat@kernel.org, andrew.cooper3@citrix.com,
        jiangshanlai@gmail.com
Subject: Re: [PATCH v10 02/38] x86/opcode: Add the WRMSRNS instruction to
 the x86 opcode map
Message-Id: <20230915144710.7c2b94e93db16fd217acaf9f@kernel.org>
In-Reply-To: <20230914044805.301390-3-xin3.li@intel.com>
References: <20230914044805.301390-1-xin3.li@intel.com>
        <20230914044805.301390-3-xin3.li@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, 13 Sep 2023 21:47:29 -0700
Xin Li <xin3.li@intel.com> wrote:

> Add the opcode used by WRMSRNS, which is the non-serializing version of
> WRMSR and may replace it to improve performance, to the x86 opcode map.
> 
> Tested-by: Shan Kang <shan.kang@intel.com>
> Signed-off-by: Xin Li <xin3.li@intel.com>

This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
>  arch/x86/lib/x86-opcode-map.txt       | 2 +-
>  tools/arch/x86/lib/x86-opcode-map.txt | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
> index 5168ee0360b2..1efe1d9bf5ce 100644
> --- a/arch/x86/lib/x86-opcode-map.txt
> +++ b/arch/x86/lib/x86-opcode-map.txt
> @@ -1051,7 +1051,7 @@ GrpTable: Grp6
>  EndTable
>  
>  GrpTable: Grp7
> -0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B)
> +0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B) | WRMSRNS (110),(11B)
>  1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B)
>  2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
>  3: LIDT Ms
> diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
> index 5168ee0360b2..1efe1d9bf5ce 100644
> --- a/tools/arch/x86/lib/x86-opcode-map.txt
> +++ b/tools/arch/x86/lib/x86-opcode-map.txt
> @@ -1051,7 +1051,7 @@ GrpTable: Grp6
>  EndTable
>  
>  GrpTable: Grp7
> -0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B)
> +0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B) | WRMSRNS (110),(11B)
>  1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B)
>  2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
>  3: LIDT Ms
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
