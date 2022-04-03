Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317544F0CFE
	for <lists+linux-edac@lfdr.de>; Mon,  4 Apr 2022 01:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376678AbiDCXmF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 3 Apr 2022 19:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiDCXmE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 3 Apr 2022 19:42:04 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156E62C650;
        Sun,  3 Apr 2022 16:40:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KWr433rm5z4xQt;
        Mon,  4 Apr 2022 09:40:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1649029204;
        bh=/LriDKMelIcxILEmiYYeCqxlA2ksNDFTy/6Du99U0M0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bNKCIoOS1dKV4A+yR8Lzn3bKxXn6Q4y+cSWZ+UySUcNOU2esHkogkuMnuQ8tUwGWG
         E4+xVzwdq+CI6uYIDqGcJOVdVTA39Xi6+iwxC2N60edew1qa6BqS3YSwRrFkMNbLzb
         UKWOB+rxa/o13GAqkB2bDrB9/UUg2bzgP0wgsXwb1fdIHMtDoM7V/6wvihGxsjaxl4
         qqQnp9eRSiUARP3SBMHP/RZNBdqig4pvejApvunCHWNuGA4QcD9HYi7ztmQz2Z6xaD
         UXVMb1PWO+RXsFDLle+1ILDGTQea7lgKOFmVN2i7pP2P+10eAmnpvI6pjbcVJ+xTx5
         zia8dmxq/Nz6Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Borislav Petkov <bp@alien8.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
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
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc/85xx: Remove fsl,85... bindings
In-Reply-To: <YkbOg4iLykg0gkKz@zn.tnic>
References: <82a8bc4450a4daee50ee5fada75621fecb3703ff.1648721299.git.christophe.leroy@csgroup.eu>
 <YkbOg4iLykg0gkKz@zn.tnic>
Date:   Mon, 04 Apr 2022 09:40:00 +1000
Message-ID: <87bkxhg2i7.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:
> On Thu, Mar 31, 2022 at 12:13:10PM +0200, Christophe Leroy wrote:
>> Since commit 8a4ab218ef70 ("powerpc/85xx: Change deprecated binding
>> for 85xx-based boards"), those bindings are not used anymore.
>> 
>> A comment in drivers/edac/mpc85xx_edac.c say they are to be removed
>> with kernel 2.6.30.
>> 
>> Remove them now.
>> 
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>  .../bindings/memory-controllers/fsl/fsl,ddr.yaml   |  6 ------
>>  .../devicetree/bindings/powerpc/fsl/l2cache.txt    |  6 ------
>>  drivers/edac/mpc85xx_edac.c                        | 14 --------------
>>  3 files changed, 26 deletions(-)
>
>
> I'll take it through the EDAC tree of there are no objections.

Fine by me, thanks.

cheers
