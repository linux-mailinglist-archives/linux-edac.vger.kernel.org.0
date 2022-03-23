Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9548B4E5AA1
	for <lists+linux-edac@lfdr.de>; Wed, 23 Mar 2022 22:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244538AbiCWV1T (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Mar 2022 17:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiCWV1S (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 23 Mar 2022 17:27:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EC6140A0
        for <linux-edac@vger.kernel.org>; Wed, 23 Mar 2022 14:25:47 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B336C1EC0576;
        Wed, 23 Mar 2022 22:25:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648070741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5MCv+N0zduaIP+Ux0XDMI9kuoeMG8P1BddCkQIE1NoA=;
        b=DwAOtM7DcvRfEzxbxCIK7WecQEXW413cMc1DUOaOroFG1k8BA8vF3LouAERlUSot2nd/pX
        rco02Cl/CiuV1eATPd1hLyz6AxMvOKuaqsJ0eX8qE30zUu86T1n8JBc6dukxEEr6shjEXr
        vEnf6ggRmE9vjcmzvdG4n20OuhFjcG8=
Date:   Wed, 23 Mar 2022 22:25:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Naveen Krishna Chatradhi <nchatrad@amd.com>,
        linux-edac@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        Muralidhara M K <muralimk@amd.com>
Subject: Re: [PATCH 01/14] EDAC/amd64: Move struct fam_type variables into
 struct amd64_pvt
Message-ID: <YjuQUq+2LlGnMHhg@zn.tnic>
References: <20220228161354.54923-1-nchatrad@amd.com>
 <20220228161354.54923-2-nchatrad@amd.com>
 <YjtWnqnH7ytG2K/j@yaz-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YjtWnqnH7ytG2K/j@yaz-ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Mar 23, 2022 at 05:19:26PM +0000, Yazen Ghannam wrote:
> I just noticed that families 15h and 16h aren't matching against a model
> range. I think we should look into that.

And while you're doing that, you could make those ranges a lot more
readable by using a second switch-case on the model. For example, with
F19h:

        case 0x19:
                switch (pvt->model) {
                case 0x10 ... 0x1f:
                        fam_type = &family_types[F19_M10H_CPUS];
                        pvt->ops = &family_types[F19_M10H_CPUS].ops;
                        break;
                case 0x20 ... 0x2f:
                        fam_type = &family_types[F17_M70H_CPUS];
                        pvt->ops = &family_types[F17_M70H_CPUS].ops;
                        fam_type->ctl_name = "F19h_M20h";
                        break;
                case 0x50 ... 0x5f:
                        fam_type = &family_types[F19_M50H_CPUS];
                        pvt->ops = &family_types[F19_M50H_CPUS].ops;
                        fam_type->ctl_name = "F19h_M50h";
                        break;
                case 0xa0 ... 0xaf:
                        fam_type = &family_types[F19_M10H_CPUS];
                        pvt->ops = &family_types[F19_M10H_CPUS].ops;
                        fam_type->ctl_name = "F19h_MA0h";
                        break;
                default:
                        fam_type = &family_types[F19_CPUS];
                        pvt->ops = &family_types[F19_CPUS].ops;
                        family_types[F19_CPUS].ctl_name = "F19h";
                        break;
                }
                break;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
