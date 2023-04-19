Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993EB6E8188
	for <lists+linux-edac@lfdr.de>; Wed, 19 Apr 2023 20:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjDSSzj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 19 Apr 2023 14:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDSSzi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 19 Apr 2023 14:55:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E889744A6;
        Wed, 19 Apr 2023 11:55:37 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 442081EC0646;
        Wed, 19 Apr 2023 20:55:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681930536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xU3KU7usX7t1yq/lRNZgSLpwb99lOZ/j/rMKmfbn/C4=;
        b=Sa10NsJ4yQ9UTK+9BMD34vWMmOYLV9cxcQj42ttDVPMAOb4PpN9kwVFgB3kd7ICHxwZmcX
        p3Nkiyf7Tw06TNxstx5QHmSjOFXdf7pRFqrMg0TKFJIslpvPODtARyGATA1ER3NnVA/0rw
        R+w0TVrE0dc9J/PY0tHPKj8GJgvx5pg=
Date:   Wed, 19 Apr 2023 20:55:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] edac: cpc925: Use of_get_cpu_hwid() to read CPU node
 'reg'
Message-ID: <20230419185535.GGZEA5J2ZVxsv5AlBM@fat_crate.local>
References: <20230319150141.67824-1-robh@kernel.org>
 <20230319150141.67824-2-robh@kernel.org>
 <20230418175000.GLZD7YSNkIKk8ltGIw@fat_crate.local>
 <20230419184547.GA4013083-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230419184547.GA4013083-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Apr 19, 2023 at 01:45:47PM -0500, Rob Herring wrote:
> I'd rather not export of_get_cpu_hwid() which is otherwise only used in 
> arch code. I think I'll rewrite this in terms of for_each_possible_cpu() 
> and topology_core_id(). Though that would make a UP build not enable 
> core 1, but that seems undesirable anyways.

TBH I'm not sure this driver is even worth any effort besides simply
deleting it. I see one commit which reads like someone was really using
it:

ce395088832b ("cpc925_edac: Support single-processor configurations")

but that one is from 2011 and since then it has received only API
modifications/cleanups.

But if I delete it, someone might crawl out of the woodwork and say it
is still used...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
