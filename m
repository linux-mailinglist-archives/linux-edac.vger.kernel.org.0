Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD42704AC2
	for <lists+linux-edac@lfdr.de>; Tue, 16 May 2023 12:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjEPKfH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 May 2023 06:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjEPKev (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 May 2023 06:34:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E232C35AE;
        Tue, 16 May 2023 03:34:13 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DDE091EC0629;
        Tue, 16 May 2023 12:34:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1684233247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9OIgfcxNybX1lKTVO2G6haRHWMaFmHKjrGEunKK9mDU=;
        b=ZEjm0WwitFAKv7EPjrRL0B7tKknKirWdplPmkSROsF6H4DNIAbJUCkB691GtrUGXIjDD73
        D5LdOr22/F0aFhrlraMVXVKrflUpSe8O12f1E+OZO9ZIwqT5cs/epF35Yk3k15YmSp/hXn
        GW6fq543t68Fm+HGUczorRCKQxhvzrc=
Date:   Tue, 16 May 2023 12:34:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] EDAC: Expose node link in sysfs if CONFIG_NUMA
Message-ID: <20230516103403.GBZGNcG7Q1sdtUpcHW@fat_crate.local>
References: <20230516080748.3155788-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230516080748.3155788-1-yajun.deng@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 16, 2023 at 04:07:48PM +0800, Yajun Deng wrote:
> The node in sysfs already has cpu link and memory link, the memory
> control also under a node.
> 
> Expose node link to memory control directory and expose memory control
> link to node directory if CONFIG_NUMA.

Why?

> At the same time, change the type of EDAC from tristate to boolean
> because it needs node_devices.

Nope.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
