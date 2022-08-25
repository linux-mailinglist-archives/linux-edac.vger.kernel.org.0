Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E054B5A0BA7
	for <lists+linux-edac@lfdr.de>; Thu, 25 Aug 2022 10:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbiHYIhn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 25 Aug 2022 04:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbiHYIhj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 25 Aug 2022 04:37:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28DAA74C9;
        Thu, 25 Aug 2022 01:37:36 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9859329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9859:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 476161EC068E;
        Thu, 25 Aug 2022 10:37:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661416651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xglsEXySyMIRCcSyVb8o4Podyece74iheAqRSmgtN3Y=;
        b=g7Oqe86L0hvEw5+FsmgEd3XOzDIaIG77Apt61mWNXZaSgC2DPUKQ3U4CbE/kYuqU4TAqgZ
        6ZDYWDyWa0GGddH5El/xwTG2Q3kBNDTDWjysm7s03FzXZnOlbbZIlRdZ1qT+cptpclwSRM
        v+7wbbksh2NLMV5Vg/CkFbxl1XVVdZ0=
Date:   Thu, 25 Aug 2022 10:37:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Hant <joshuahant@gmail.com>
Cc:     jbaron@akamai.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] EDAC/ie31200: Add Skylake-S support
Message-ID: <Ywc0x4AMfcX9HeFs@zn.tnic>
References: <ab77d779-31a6-62f7-a81c-97d6b9a35018@akamai.com>
 <20220716005348.13756-1-joshuahant@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220716005348.13756-1-joshuahant@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jul 15, 2022 at 08:53:48PM -0400, Josh Hant wrote:
> Add device IDs for Skylake-S CPUs according to datasheet.
> 
> Signed-off-by: Josh Hant <joshuahant@gmail.com>
> ---
> Here is the patch with both documents included.
> 
> Thanks,
> Josh
> 
>  drivers/edac/ie31200_edac.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
