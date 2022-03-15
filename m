Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EF34DA278
	for <lists+linux-edac@lfdr.de>; Tue, 15 Mar 2022 19:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351075AbiCOSiF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Mar 2022 14:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351097AbiCOSiC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Mar 2022 14:38:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D791483BB;
        Tue, 15 Mar 2022 11:36:50 -0700 (PDT)
Received: from zn.tnic (p5de8e440.dip0.t-ipconnect.de [93.232.228.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A46BC1EC04C1;
        Tue, 15 Mar 2022 19:36:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647369404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JjvDDVjCifPJvTUzn+nwAnDCaFN2QldIAfWhx2SS42I=;
        b=j3WZ6Nab/2RxzMCSJtXS4vd4YVwY4+8yI0z6+rHAlbXVUUp5XeyK54YcZ81dvK83Fhajg3
        3GTXhSLXc5wzMWixD4g2CRi1VOgGTRfP5exOnqsJkWKAp/R78Ze0vkArDOqZWnboIdZD18
        Q+fYJxc0XOHIhy0GeFTwYEegeYL/fEA=
Date:   Tue, 15 Mar 2022 19:34:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v2 0/2] New CMCI storm mitigation for Intel CPUs
Message-ID: <YjDcN9XRa0teenD2@zn.tnic>
References: <Yg6FqR2cMZDwdBdi@agluck-desk3.sc.intel.com>
 <20220315181509.351704-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220315181509.351704-1-tony.luck@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Mar 15, 2022 at 11:15:07AM -0700, Tony Luck wrote:
> Smita: Unless Boris finds a some more stuff for me to fix, this
> version will be a better starting point to merge with your changes.

Right, I'm wondering if AMD can use the same scheme so that abstracting
out the hw-specific accesses (MSR writes, etc) would be enough...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
