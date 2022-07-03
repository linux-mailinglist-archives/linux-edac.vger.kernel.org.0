Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF93B564744
	for <lists+linux-edac@lfdr.de>; Sun,  3 Jul 2022 14:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiGCMaf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 3 Jul 2022 08:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiGCMae (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 3 Jul 2022 08:30:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53F626C9;
        Sun,  3 Jul 2022 05:30:33 -0700 (PDT)
Received: from zn.tnic (p200300ea970ff65c329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:f65c:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6A89E1EC0666;
        Sun,  3 Jul 2022 14:30:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1656851428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wn9uQnAuwFGrab8kpHKs8SGNaKDnyC8vS2rlkoo88JI=;
        b=YW7aqJN9n9rpT494I3ull/tEVWXbJPHATT5u8+cLdngahgrQS4l5ZyvytD45bUrgqx8SXj
        qwQMZoaaqw6zESxDOrqstLy7zmOeyOshy+JL/xP/+4O9p2lRMTQMYdW04FnpdJTtTDKJEh
        EOgheD6zTSvVLYRZnMO8mxxdG3YsP5E=
Date:   Sun, 3 Jul 2022 14:30:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH 2/3] x86/MCE/APEI: Handle variable register array size
Message-ID: <YsGL4JbTGF3Rcg9G@zn.tnic>
References: <20220418174440.334336-1-yazen.ghannam@amd.com>
 <20220418174440.334336-3-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220418174440.334336-3-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Apr 18, 2022 at 05:44:39PM +0000, Yazen Ghannam wrote:
> Recent AMD systems may provide an x86 Common Platform Error Record
> (CPER) for errors reported in the ACPI Boot Error Record Table (BERT).
> The x86 CPER may contain one or more Processor Context Information
> Structures. The context structures may represent an x86 MSR range where
> a starting address is given, and the data represents a contiguous set of
> MSRs starting from, and including, the starting address.

You're killing me with these "may" formulations. Just say it once and
then drop it. I mean, we know some future hw "may" support something
new - you can just as well drop the "may" thing because if it only may
and it turns out it might not, you don't even have to do the work and
enabling it and sending the patch.

So no need to do that - the patch commit message should talk purely
about functionality and not sound like some vendor doc - there are
enough of those.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
