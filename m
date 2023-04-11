Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7366DE249
	for <lists+linux-edac@lfdr.de>; Tue, 11 Apr 2023 19:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjDKRRc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 Apr 2023 13:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjDKRR0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 11 Apr 2023 13:17:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F636195;
        Tue, 11 Apr 2023 10:17:12 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 297DA1EC063A;
        Tue, 11 Apr 2023 19:17:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681233431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sRJD3M3R2LOUr8zj5FBJCAopP5+RNf9PQTOwzxCyAJ4=;
        b=cnOWrfxOfZznyJPkdXy4KpynAIxdUi0EprtM4xHRu78dTfbgkKXUJVzZacxqoLlfk1Lwb8
        hQZkXkt59GzxV9KQdOXCkRBt4RChExThc6zTlK1J1rkPk5g5miD3l1crKN12aijbdSZTw9
        i0OaDVJVMsN+IVZ6+pqLV/URCdkzMjg=
Date:   Tue, 11 Apr 2023 19:17:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v4 2/5] x86/mce: Add per-bank CMCI storm mitigation
Message-ID: <20230411171710.GDZDWWFu9tKgSPt/Fh@fat_crate.local>
References: <ZCRYl9c7xgIJ+pJe@yaz-sghr>
 <20230403210716.347773-1-tony.luck@intel.com>
 <20230403210716.347773-3-tony.luck@intel.com>
 <20230411123234.GGZDVTYppLWRN5t0jX@fat_crate.local>
 <6b6e53c5-8562-8ea0-befa-88c8b38663d6@amd.com>
 <SJ1PR11MB6083508C64838C99F4C103C7FC9A9@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083508C64838C99F4C103C7FC9A9@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Apr 11, 2023 at 04:06:17PM +0000, Luck, Tony wrote:
> Boris: Have you seen anything else that needs fixing?

Not yet. I stopped looking at the build failure.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
