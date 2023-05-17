Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4AD706181
	for <lists+linux-edac@lfdr.de>; Wed, 17 May 2023 09:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjEQHnj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 May 2023 03:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjEQHni (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 17 May 2023 03:43:38 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9D6DA;
        Wed, 17 May 2023 00:43:37 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aad5245632so3849265ad.3;
        Wed, 17 May 2023 00:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684309416; x=1686901416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AU3J/HsqQVRlMwMH3f4tzrQckFj4RWJ9EFF4TdzVoM8=;
        b=p+8Y7nCSjBwd0Txc/uaBFWBkCts5w/Wz2jfTlH8jSaaeD6afKtohm+W6cUHyuEthE2
         r1znL/TCEGb17+VRn4amdwez5DWS4KPl0S6pnf+ijgSn+2EGyuVALEPThGqQyk9S6tqW
         IQJ08tUDEDWT2JXKi9ptN2ZsWMqQbx0mOSXsiqI1EH3NAmhrgvy/AaBSP1Mw3wSEeUcM
         7Iuv/uwzl1qC6zRH7ARkMFR/ItKgqdSvcthV212A2OdgpDyYKk9mtpyXJG+aPL4D3Rtu
         3CgghUQEyNvoZwuQ1xaY3klsBtTaEepFPqnh0+irhlv75NHR+gTe9m01Ns47Rrl2IrZj
         C2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684309416; x=1686901416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AU3J/HsqQVRlMwMH3f4tzrQckFj4RWJ9EFF4TdzVoM8=;
        b=htG5ZQYsN0YkNSCj3qdQWkwrkDR5/yaikD7sxfZAQn9veDK3OFFWvV7LgA4rv0fYwp
         Tkqp3xsb65Om4JMTmQhQHbuRmjPucvpb6m39yKZBF8cMHovEL7nGr0jIRQ2/E3LLOycf
         7kubi9/SyG7anhf+zXQEk36nx7IsApZ31BEyw1b2IZH8p49mYBGa2fsfXGmRinNgpk4V
         D1FGiB2EYDiciFXH8nvweMjn2uNqs/QmnwwAZRdv1i+cNPGLBoj8glSB9Lhao7kCUhvh
         F7fn2t8Peny5jiOpqpSDGdxe+rQyuLGPpf93vpnvMN50tDkKH0fX1fFok/qS34Z+OP/2
         P+Bw==
X-Gm-Message-State: AC+VfDzEaQWEcGic8XNWcMEsBuRaPiAvrM5jzlHBGM3ZoP5/DGIJ7kNE
        +GkAJVOItGft9U9bmdQXPUw=
X-Google-Smtp-Source: ACHHUZ7LYASxbc0VHDUh+FhBTnPCiL8PXB7RwPBFPbT1QNVrZmsdjcVwlmt4xOIrIpCOV5roWAL5fw==
X-Received: by 2002:a17:902:ecc4:b0:1ad:8c8f:afb1 with SMTP id a4-20020a170902ecc400b001ad8c8fafb1mr31335207plh.39.1684309416523;
        Wed, 17 May 2023 00:43:36 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-12.three.co.id. [180.214.232.12])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001ac6b926621sm15174961plq.292.2023.05.17.00.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 00:43:36 -0700 (PDT)
Message-ID: <723b9f11-d427-6c5d-5d99-969550244129@gmail.com>
Date:   Wed, 17 May 2023 14:43:30 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] EDAC: Expose node link in sysfs if CONFIG_NUMA
Content-Language: en-US
To:     Yajun Deng <yajun.deng@linux.dev>, bp@alien8.de,
        tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230516080748.3155788-1-yajun.deng@linux.dev>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230516080748.3155788-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 5/16/23 15:07, Yajun Deng wrote:
> +
> +What:		/sys/devices/system/edac/mc/mc*/node*
> +Date:		May 2023
> +Contact:	Yajun Deng <yajun.deng@linux.dev>
> +		linux-edac@vger.kernel.org
> +Description:	When CONFIG_NUMA is enabled, a symbolic link that points to the
> +		corresponding NUMA node directory.
> +
> +		For example, the following symbolic link is created for node0 on mc0
> +		and mc1:
> +

"For example, on node0 with two memory control directories mc0 and mc1
the symlinks are::" (I prefer using literal code block here).

> +		/sys/devices/system/edac/mc/mc0/node0 -> ../../../node/node0
> +		/sys/devices/system/edac/mc/mc1/node0 -> ../../../node/node0

Or bullet lists should better fit listing above?

> +
> +What:		/sys/devices/system/node/node*/mc*
> +Date:		May 2023
> +Contact:	Yajun Deng <yajun.deng@linux.dev>
> +		linux-edac@vger.kernel.org
> +Description:	When CONFIG_NUMA is enabled, a symbolic link that points to the
> +		corresponding memory control directory.
> +
> +		For example, the following symbolic link is created for mc0 and mc1
> +		on node0:
> +
> +		/sys/devices/system/node/node0/mc0 -> ../../edac/mc/mc0
> +		/sys/devices/system/node/node0/mc1 -> ../../edac/mc/mc1

Similar as my review above.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

