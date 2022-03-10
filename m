Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693054D4E2F
	for <lists+linux-edac@lfdr.de>; Thu, 10 Mar 2022 17:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240698AbiCJQKP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Mar 2022 11:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240672AbiCJQKP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Mar 2022 11:10:15 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B18618DAB4;
        Thu, 10 Mar 2022 08:09:14 -0800 (PST)
Received: from zn.tnic (p200300ea971938780dcf83143dcfc403.dip0.t-ipconnect.de [IPv6:2003:ea:9719:3878:dcf:8314:3dcf:c403])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AAF941EC0295;
        Thu, 10 Mar 2022 17:09:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646928548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yx08IRwrdan+Mo3WyLuiUJbzxkiwNi4eKWLpFxN4RSU=;
        b=CcSDpu8hbeYpCKhe3NkIY/bbWNHEpXJ49JcfamVD6NCRsPvchLtjJeSRTJ9tWL25eBqtHZ
        X2pByUwFsL1bFdQaVr4hGXzcnLj5arAzNDDnTXRJ39HU4RLGBAcoA/EIvHmDSkoMLJ4cEW
        NfE8ib++jzBXrIgUCm5MSnZxLU3BHnA=
Date:   Thu, 10 Mar 2022 17:09:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v4 10/24] EDAC/amd64: Define function to get Interleave
 Address Bit
Message-ID: <Yioir2htNGGz/QG7@zn.tnic>
References: <20220127204115.384161-1-yazen.ghannam@amd.com>
 <20220127204115.384161-11-yazen.ghannam@amd.com>
 <YgpGyceWKsIVYuGv@zn.tnic>
 <YikmMHYpdehehD9F@yaz-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YikmMHYpdehehD9F@yaz-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Mar 09, 2022 at 10:12:00PM +0000, Yazen Ghannam wrote:
> Similar goal as in other places. When the function seems sufficiently long
> (subjective I know), break it up into helper functions.
> 
> I've been trying to decide based on logical steps. Do you have any general
> recommendations or rule-of-thumb?

Documentation/process/coding-style.rst, 6) Functions has some good ideas
about it. To me, a function should do one thing and one thing only but
yes, the decision is subjective.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
