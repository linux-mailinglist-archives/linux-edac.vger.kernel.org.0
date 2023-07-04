Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781A0746C8B
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jul 2023 10:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjGDI7c (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jul 2023 04:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjGDI7c (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Jul 2023 04:59:32 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6D21AD
        for <linux-edac@vger.kernel.org>; Tue,  4 Jul 2023 01:59:26 -0700 (PDT)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7D1133F18A
        for <linux-edac@vger.kernel.org>; Tue,  4 Jul 2023 08:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688461165;
        bh=Iq6cKg1bVkNflRBjs/XMRCMTTeQAcRlxHohCnato/0M=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=rpuWdPYUpR8GPErV/UPnnQ3qBkv3X6fVpqnzov8nRCK+/WSXtdYfYyAiqzxyJ0Ij1
         xEeuoIaAItjAPynP+z0hIN8sjdgLLZFmjQTlXaz+y6CvWPPEgirBRr6jJ4LCOXIwzm
         b2tB+xluPQj3QUHj5E9WiqOme7h4b3lS3ScjPe6kOn0N4CXcpwmE4+hk2t9Znsyal1
         pSqRc1B8NNqJQkctTXIKtO5RttzEiH0Hd7kLWkR4KqDb0psqRDzOhnZ+QdD9pIfv42
         fuY9sGQnb7KJnGI28erY29oW2Js54wtEeUpTXc1SmKN16wXaERaKbD5xF7lG0z7KYi
         ENCNJvZ8X/AgA==
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-666eb0346c4so4828420b3a.0
        for <linux-edac@vger.kernel.org>; Tue, 04 Jul 2023 01:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688461164; x=1691053164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iq6cKg1bVkNflRBjs/XMRCMTTeQAcRlxHohCnato/0M=;
        b=fkjpPCrccyo82/JYHRdGSbxj8fX58soHos/Jvsza1t49EqYO/jmR76vlFWuSIJIywh
         VSKjmZ1kfPWWWOYvvtEamzggs4VOCFgoD5yYH9UpUd70wsAEGrP/lFQIM6yG7/CvYrIB
         4b5OtzmJL0Q7USYLCPsVvt2IqSwX0aXKGlZ0aGfNHDo+0PByUJ+NmUqtrG36ksQ+vbkj
         Bq8noIp+MXn8RFmHlGdaLjzlkX9bbEqlqMBoNKBWMMvg9B+dSWqLEhBBcKuKcXiopM8F
         M6oufVbjQiFM317KDKfelZtrwNL41QaB29oPkSuO14xZRhzVfDUHHxG9YvW1h3S2Bjb/
         xNEg==
X-Gm-Message-State: ABy/qLa37HVQwvM6JUk40eERynoTp9jZErZcCQ7MCU6Gmyn/PaVyVRwb
        XaJfz990koG9lrA1mAJsFK5TXfgv89GSJVRsYQeSGJs6/RQYjp6NlGPxEu7FtQXnJIcb5+Z83x2
        +3CzSlaS/Hk/5/xQaVMwSeZVHoq5RITfKLYXn3Vsh3QMSgqeTNlMhTWI=
X-Received: by 2002:a05:6a00:c8c:b0:67d:ccbc:5e81 with SMTP id a12-20020a056a000c8c00b0067dccbc5e81mr13255046pfv.4.1688461164103;
        Tue, 04 Jul 2023 01:59:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEA4BMzE4N8gwue1FHSWScEaB/ukcJ0jLDn6CFHKEFH69V6wIcnboq78jkqkyl7LecvUNNmcVKK25UHVuk3664=
X-Received: by 2002:a05:6a00:c8c:b0:67d:ccbc:5e81 with SMTP id
 a12-20020a056a000c8c00b0067dccbc5e81mr13255036pfv.4.1688461163739; Tue, 04
 Jul 2023 01:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230703162509.77828-1-koba.ko@canonical.com> <4ec2b7d2-11a5-6ab6-087a-175ed31faca4@web.de>
 <SJ1PR11MB60839A0FC6B5E79E3E5A7997FC29A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+X+09-m57JcZcb-_9dKUG3CtAbLXxGTEg7R0bB8pyJx9Q@mail.gmail.com>
 <CAJB-X+XVO29wVxVezjFrgCyXigqEJxAzb0K0wueXNto5K_x2tA@mail.gmail.com>
 <9c27530e-21f9-15ce-5116-5af5b0c25f53@web.de> <CAJB-X+VjjxLi60k-6VNcypMB8EomJ0uYpDdfwpJ1dHPWRG7Vxg@mail.gmail.com>
 <706f49e8-d536-651a-2f19-394518633b53@web.de>
In-Reply-To: <706f49e8-d536-651a-2f19-394518633b53@web.de>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Tue, 4 Jul 2023 16:59:12 +0800
Message-ID: <CAJB-X+Wv6yeJLhWogopd5HyJADwLqSdmhfrh_P+-P02SEOACQQ@mail.gmail.com>
Subject: Re: [v2/v3] EDAC/i10nm: shift exponent is negative
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jul 4, 2023 at 4:50=E2=80=AFPM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> > @Markus and all,
> > please review it, thanks
> >
> > Subject: [PATCH][V3] EDAC/i10nm: Fix an inappropriate shift exponen
>
> * Combined prefixes would be nicer.
Do you mean, [PATCH V3]?
> * Please avoid a typo here.

=3D> exponent

>
> > when get rows, cols and ranks, A special value combination could not
> > be handled so far.
>
> It seems that you stumble still on wording difficulties.

remove the previous sentence,
A special value combination could not be handled so far.

>
> > Fixes: 4ec656bdf43a13 (EDAC, skx_edac: Add EDAC driver for Skylake)
>
> You overlooked somehow to use double quotes here.

must be
Fixes: 4ec656bdf43a13 ("EDAC, skx_edac: Add EDAC driver for Skylake")

> Please provide the next version of a proper patch.
>
> Regards,
> Markus
