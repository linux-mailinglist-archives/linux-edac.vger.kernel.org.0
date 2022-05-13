Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D51525F02
	for <lists+linux-edac@lfdr.de>; Fri, 13 May 2022 12:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379221AbiEMJ4P (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 13 May 2022 05:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355353AbiEMJ4O (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 13 May 2022 05:56:14 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D5C1402C;
        Fri, 13 May 2022 02:56:12 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C6FDC1EC069A;
        Fri, 13 May 2022 11:56:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652435766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qZU+VowKBrdGf3U5Q1GiT7jwO9RXiaZ1Fk4oM0FeUKk=;
        b=WlWppcm86nod9C3ir0FTP3z78QRW/KpU7UHINYTa+cp6idwyvSqu4+vvcCY1i6q3etuV/8
        zVAS2BbTXLELLnPrtM5wXQ5+CSYrfiAXG3e0wck2uSb9gCg88OyZhHdX0ItNXV3eGk3n3D
        QkY9X5XWzlKLKtDDjAAWN/1aM6ZPD80=
Date:   Fri, 13 May 2022 11:56:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, muralidhara.mk@amd.com,
        naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH 04/18] EDAC/amd64: Remove PCI Function 0
Message-ID: <Yn4rOD9CS9LFxzhx@zn.tnic>
References: <20220509145534.44912-1-yazen.ghannam@amd.com>
 <20220509145534.44912-5-yazen.ghannam@amd.com>
 <YnuRUsAcnzT4Advm@zn.tnic>
 <Yn0a9T9xqAkWnPWt@yaz-fattaah>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yn0a9T9xqAkWnPWt@yaz-fattaah>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 12, 2022 at 02:34:29PM +0000, Yazen Ghannam wrote:
> Also, there are five function pointers that are created in this patchset and
> called from hw_info_get(). I think those pointers can be dropped and the
> helper functions called from hw_info_get(). So I think it'd be good to make
> hw_info_get() into a function pointer which gets set to a functoin that calls
> the right collection of legacy, modern, and GPU helper functions. How does
> that sound?

Makes sense.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
