Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2147760B473
	for <lists+linux-edac@lfdr.de>; Mon, 24 Oct 2022 19:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiJXRpr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Oct 2022 13:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbiJXRpW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 24 Oct 2022 13:45:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FB4A3B89;
        Mon, 24 Oct 2022 09:21:13 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e790329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e790:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 53C4A1EC068C;
        Mon, 24 Oct 2022 18:09:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666627755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=a1QuOYvuRisp/EALocACHvhqq7vII+9OaWwL4wyPplo=;
        b=f78Oef8mMPh4u167RqzzXHtScFCz5EwAxJXkbHmiMdUF0SLwPTeD60zHX41N+e8u6qstgz
        uAj19Ugl/gNh30w4VlySEHUoy/sh4e7FUz22kZnY4kUSc2k02TdBxAtZNXhIvrviN94hhI
        HBVtoxn1n5dmfc9QTHpWJ0gVlum+CKA=
Date:   Mon, 24 Oct 2022 18:09:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH 1/3] x86/MCE, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Message-ID: <Y1a4prRIYNw8GIkm@zn.tnic>
References: <20220418174440.334336-1-yazen.ghannam@amd.com>
 <20220418174440.334336-2-yazen.ghannam@amd.com>
 <Yr2CpuL+JHWblJMD@zn.tnic>
 <YsxefXQDCiJ1zxLG@yaz-fattaah>
 <YtUgb2Y/H/Wq9yIn@zn.tnic>
 <YtVlNrW58cFmksln@zn.tnic>
 <YukW/IltcCRwvSM4@yaz-fattaah>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YukW/IltcCRwvSM4@yaz-fattaah>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 02, 2022 at 12:22:20PM +0000, Yazen Ghannam wrote:
> I ask because struct mce is UAPI. But I think this is just for /dev/mcelog,
> and this has been deprecated for a while. So on a related note, should
> /dev/mcelog be removed and struct mce moved out of UAPI? Then changes to
> struct mce won't affect user space, and we can just consider the mce trace
> event when reporting to user space.

Question is, do you want those error records to be fed into mcelog on
AMD too?

And I remember you guys supporting it at some point.

The answer to that question will tell you how exactly to build your
structure of data you shuffle to luserspace.

I'd say.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
