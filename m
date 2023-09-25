Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F9C7ADDA8
	for <lists+linux-edac@lfdr.de>; Mon, 25 Sep 2023 19:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjIYRNc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Sep 2023 13:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjIYRNb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 25 Sep 2023 13:13:31 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110BE126
        for <linux-edac@vger.kernel.org>; Mon, 25 Sep 2023 10:13:22 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-565334377d0so5206067a12.2
        for <linux-edac@vger.kernel.org>; Mon, 25 Sep 2023 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695662001; x=1696266801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C8AVXr6vllU577ND8JQi6s5Wb2XnBxy1FQk2gXYImts=;
        b=nwdwXGckYPlPX21pEof3xnvcqZtcLo+KJ3+jVK0axkL3B9r8vRWYdHvuPmYQG+0SMW
         0kplhw0TQhtU0Iwi8LNa4wT1D+uBm3rl8SZyA+8Yw+2aNjTVr3NIha6HuMFqSvToYIPN
         2KvBec9sl1KfxAXU/PbYcm2nl3P/IgqmPDnkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695662001; x=1696266801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8AVXr6vllU577ND8JQi6s5Wb2XnBxy1FQk2gXYImts=;
        b=k8wa6rLEDhvOoW+XJF5FDawZws5FcEkJmrjvBjfjB47IXfGA6YDSBMdmAp2HzI6voM
         JiLph0OOvDqjTBvXGk4nFtjTv4PSVTVlzbTY7trwu0vOZrML5OoTJxocn56L0EwTbkZ9
         QmVyJGGCWEkH/iklUTd9pQTC2A5BP2fisjBCTZ/eoGhMd1CvN/WZbwGSdV4CV3WO6C2o
         4Ny4l+ByRZ0uA7Gom680p4BH6OMXAJuT5n73lOajcm4UWvYsM+F3Fn5FMm7hk6g8/I30
         84wpeshlASrnIqi2xv5ES/7QTOtUFbRGB3tJHguDFf+pqRMNafiMiQWEhUDnCF3Yttkw
         DpTQ==
X-Gm-Message-State: AOJu0Yz9/aHYXbSwZqUkFNPI59krrOWp/nnHBS69OTAExUIXv263ZJv7
        nWtqYt/SncefbSOQYyNh4CMwrg==
X-Google-Smtp-Source: AGHT+IHWl3AN866Dif5RDGSG6cKkeY0zzlRZ9iz5O7jZ3LOhJATZBUXvLNzYu+Ccp3gZwtb6gOE9uw==
X-Received: by 2002:a17:90a:4e4e:b0:268:f987:305f with SMTP id t14-20020a17090a4e4e00b00268f987305fmr6859749pjl.46.1695662001491;
        Mon, 25 Sep 2023 10:13:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 20-20020a17090a199400b00268b439a0cbsm9146846pji.23.2023.09.25.10.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 10:13:21 -0700 (PDT)
Date:   Mon, 25 Sep 2023 10:13:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     tony.luck@intel.com, gpiccoli@igalia.com, rafael@kernel.org,
        lenb@kernel.org, james.morse@arm.com, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        robert.moore@intel.com, linux-hardening@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org,
        baolin.wang@linux.alibaba.com
Subject: Re: [RFC PATCH v2 1/9] pstore: move pstore creator id, section type
 and record struct to common header
Message-ID: <202309251012.AD87704BB@keescook>
References: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
 <20230925074426.97856-2-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925074426.97856-2-xueshuai@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 25, 2023 at 03:44:18PM +0800, Shuai Xue wrote:
> Move pstore creator id, section type and record struct to the common
> header, so that it can be use by MCE and GHES driver.

I would prefer this was not in the pstore header -- this is a backend
detail that should stay in backend headers.

-Kees

-- 
Kees Cook
