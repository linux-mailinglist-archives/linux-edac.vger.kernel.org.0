Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0924EEAF4
	for <lists+linux-edac@lfdr.de>; Fri,  1 Apr 2022 12:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344943AbiDAKID (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 1 Apr 2022 06:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344904AbiDAKHx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 1 Apr 2022 06:07:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B42173F4E;
        Fri,  1 Apr 2022 03:06:03 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 287B01EC04E0;
        Fri,  1 Apr 2022 12:05:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648807558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rYRUcibzVb3ckmbYqIdIxEGZb0sFcGrGt8Ae3WW1QWI=;
        b=AVMN0pLDq+zP9Hdb3zEYkqcplHcFnlplTK8v/knUSnFRt9KJuP33WV87y4fh6wbj76GMcH
        X1q/Wc3VuVGGnUrTyXMP2wW3JJjYAgiI/oF+QpIn0ZSY8cTgRUrtmXfllKQNBene6dmrSj
        yPx5XrzSpaYTe6EKfi9yVDcE2Mq4O+w=
Date:   Fri, 1 Apr 2022 12:05:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Scott Wood <oss@buserror.net>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/85xx: Remove fsl,85... bindings
Message-ID: <YkbOg4iLykg0gkKz@zn.tnic>
References: <82a8bc4450a4daee50ee5fada75621fecb3703ff.1648721299.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82a8bc4450a4daee50ee5fada75621fecb3703ff.1648721299.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Mar 31, 2022 at 12:13:10PM +0200, Christophe Leroy wrote:
> Since commit 8a4ab218ef70 ("powerpc/85xx: Change deprecated binding
> for 85xx-based boards"), those bindings are not used anymore.
> 
> A comment in drivers/edac/mpc85xx_edac.c say they are to be removed
> with kernel 2.6.30.
> 
> Remove them now.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  .../bindings/memory-controllers/fsl/fsl,ddr.yaml   |  6 ------
>  .../devicetree/bindings/powerpc/fsl/l2cache.txt    |  6 ------
>  drivers/edac/mpc85xx_edac.c                        | 14 --------------
>  3 files changed, 26 deletions(-)


I'll take it through the EDAC tree of there are no objections.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
