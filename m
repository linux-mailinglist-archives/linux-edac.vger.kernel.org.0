Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F8E4EFDBD
	for <lists+linux-edac@lfdr.de>; Sat,  2 Apr 2022 03:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbiDBB0a (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 1 Apr 2022 21:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiDBB03 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 1 Apr 2022 21:26:29 -0400
X-Greylist: delayed 3087 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Apr 2022 18:24:39 PDT
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAC4144B4D;
        Fri,  1 Apr 2022 18:24:39 -0700 (PDT)
Received: from [2601:449:8480:af0::46ce]
        by baldur.buserror.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <oss@buserror.net>)
        id 1naRdE-005fFq-04; Fri, 01 Apr 2022 19:28:44 -0500
Message-ID: <def6cb6b2ca84b007efea28df13075be25c70525.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Johannes Thumshirn <morbidrsa@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Date:   Fri, 01 Apr 2022 19:28:42 -0500
In-Reply-To: <82a8bc4450a4daee50ee5fada75621fecb3703ff.1648721299.git.christophe.leroy@csgroup.eu>
References: <82a8bc4450a4daee50ee5fada75621fecb3703ff.1648721299.git.christophe.leroy@csgroup.eu>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0::46ce
X-SA-Exim-Rcpt-To: christophe.leroy@csgroup.eu, krzk@kernel.org, robh+dt@kernel.org, morbidrsa@gmail.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-edac@vger.kernel.org, bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com, rric@kernel.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
X-SA-Exim-Mail-From: oss@buserror.net
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH] powerpc/85xx: Remove fsl,85... bindings
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, 2022-03-31 at 12:13 +0200, Christophe Leroy wrote:
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
>  .../bindings/memory-controllers/fsl/fsl,ddr.yaml   |  6 ------
>  .../devicetree/bindings/powerpc/fsl/l2cache.txt    |  6 ------
>  drivers/edac/mpc85xx_edac.c                        | 14 --------------
>  3 files changed, 26 deletions(-)

Acked-by: Scott Wood <oss@buserror.net>

-Scott


