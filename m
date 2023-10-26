Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F587D876D
	for <lists+linux-edac@lfdr.de>; Thu, 26 Oct 2023 19:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjJZRSh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 26 Oct 2023 13:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJZRSh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 26 Oct 2023 13:18:37 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4917E116
        for <linux-edac@vger.kernel.org>; Thu, 26 Oct 2023 10:18:35 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c8a1541232so10235405ad.0
        for <linux-edac@vger.kernel.org>; Thu, 26 Oct 2023 10:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698340715; x=1698945515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xw07DRWLKz2p8vG1tYsMr3W7FGieeNrenFoAi4zFRnI=;
        b=HadBnEolRBsouoN5HKIQwrdKGT90ph91wFGZO1Kh5BqVkPACw6uQi6tPd9qfuGP5dz
         CyoAoLWht3zZNY4Gd6Mib7/yZdbWBCsVAg6kuvQRJrw2aJnC9DLN1yzLhSNERggO6nNX
         j8y9WPuWqJUdQ21PwjJL3VJWbH3ZyDOQiocKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340715; x=1698945515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xw07DRWLKz2p8vG1tYsMr3W7FGieeNrenFoAi4zFRnI=;
        b=KthehYG133DmHnxsRyrz9sXN5PhXOrBC050dCDTH4SFhQYhkHcuo755p7q3nKnnLab
         FwFoFGeNJfVnupeSlRL9L1s87tjYW4sI0Ef2bOS+qb4WpIvY/76DSKnZRic8nW0TFcNF
         Lznw8hnDTYPhyzRAQgjhKUEzzLx+OM41dfLvfarSRNplbw6Qz0Cs3FswfT9tToQwgQzC
         vgLcAAOCC8JKqyeDGgZnsYYefVb67gWkmz3Rmwnibk8WhBUCkX2UaH4Bohe43Nt9Y0Zs
         eKOg+FaGRx1Ert6a0TCHPLVYYCJIfYp7PF5Ns3rD+foTXGqP1KagrEqLPgHan60a+lq+
         OShQ==
X-Gm-Message-State: AOJu0YzC6PfM3ZhPby7qqRQImmC564K62yrwehzm0Ikz5U0cqQu2cymU
        f1wMLHgvO1rEHVoQa8RGDfdpJg==
X-Google-Smtp-Source: AGHT+IHJaeoDvNexJ51nTj9W7C9gqugA0dotXJMCxzzBW0CIkG528rxu+gpmgCcu1OYKpZe+Tr0uBQ==
X-Received: by 2002:a17:903:40cd:b0:1c8:7822:e5c3 with SMTP id t13-20020a17090340cd00b001c87822e5c3mr143766pld.47.1698340714728;
        Thu, 26 Oct 2023 10:18:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b3-20020a170902d50300b001b8622c1ad2sm11228966plg.130.2023.10.26.10.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 10:18:34 -0700 (PDT)
Date:   Thu, 26 Oct 2023 10:18:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Robert Richter <rric@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/thunderx: Fix some potential buffer overflow in
 thunderx_ocx_com_threaded_isr()
Message-ID: <202310261016.2D17ACACE@keescook>
References: <91ec35cd8e2e86fa3d24c2e8ea6970e0437cdfd2.1697908406.git.christophe.jaillet@wanadoo.fr>
 <202310241629.0A4206316F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310241629.0A4206316F@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Oct 24, 2023 at 04:39:36PM -0700, Kees Cook wrote:
> As the replacements get longer, I would encourage you to use seq_buf
> instead -- it does all the length math internally. For example:

There's some ongoing work to make seq_buf easier to use:
https://lore.kernel.org/lkml/20231026170722.work.638-kees@kernel.org/

Perhaps we can add an "alloc" and "free" pair too, to handle this case:

>	msg = kmalloc(OCX_MESSAGE_SIZE, GFP_KERNEL);
> 	seq_buf_init(&s, msg, OCX_MESSAGE_SIZE);

But perhaps it's overkill...

-- 
Kees Cook
