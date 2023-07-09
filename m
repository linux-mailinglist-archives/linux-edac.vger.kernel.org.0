Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A8574C63E
	for <lists+linux-edac@lfdr.de>; Sun,  9 Jul 2023 17:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjGIPmk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 9 Jul 2023 11:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGIPmj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 9 Jul 2023 11:42:39 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A025FA4
        for <linux-edac@vger.kernel.org>; Sun,  9 Jul 2023 08:42:38 -0700 (PDT)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 36CB73F193
        for <linux-edac@vger.kernel.org>; Sun,  9 Jul 2023 15:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688917356;
        bh=eQ2Re41328Au+efAy/olTNwiwLMQnq+SolRCbI7Z9nk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=FCuyp/ShQ8vSKQQGhljoTEWQaLR9FlKddB8nGHmXMFIxkKlIDoiwiGbVhRUyZ7VYQ
         PedCf9Q21jQx/SiXtfugr0dYRbq1pJLpw1x8Og7DchvGwLzdoOpaNP5U6SyDWgRnAy
         4HnX7hLB5HWcavvmZvd/edUO/WesC1tLVNJShegsgcDIZaQAc9j9/cl/QxqTSRLCkG
         lV1r3BRFNIX/vkJPg/ltw851g/cdEVNTUrU0REPH6lq7QhLix386n1EsCu2DXZB6y8
         DghZxMKY865L4WxsJzZAs+wsJZXkb7wqcknkFyRTiDUtXsmATAyueGT70irbOgXMqU
         TBb66hWi++9Ng==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-55b2ac94f31so5675400a12.2
        for <linux-edac@vger.kernel.org>; Sun, 09 Jul 2023 08:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688917354; x=1691509354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQ2Re41328Au+efAy/olTNwiwLMQnq+SolRCbI7Z9nk=;
        b=ZrmKuUqpTIjoMRu87vAAZMhTJtwlO1iVVn3//sFyzpR13Uyw++FGSRbadxWcuXhm9z
         9L4UicAmV6A67qy1kak0Yaq9FgjOHpl9vLqC9kh2skWt15Fe4OX8Ho9Ze52ufQPzaYU5
         DqImb885D5pc1ou/gnOgG+yrc+QuNv8h2+/2mO+LWpW6N1s46o5k50g9CC/t+H0uTjXE
         kKhHmx5h1Kw+TzWQ027vfdno2FoFJP79fpKDeTu3koTyJOxLJINkwokJIjxxauUpZ6uL
         YQHDWO610oJ6OPlMKtmLuqqEQRrn/u5pOhTKRp8vqar6YnojqWpQW54AVbtupDeEd8vJ
         ye5w==
X-Gm-Message-State: ABy/qLZhVidT20BYSNLOgyJEqblVuu2EDQbZY2gSvUbIuR+fuWCovUdm
        ZZxyXtpOAO/TDdfcsUYCVn3UD3nMkHC6rbByI0WokbZnkAEjP6HcKo+K2DRosoxb+RaCWITRAbr
        F1trvtncBovmpYXqIW7lOT6ysAAQY6dFOle1bK2Ldw9Dgja0O8zi7Vx0=
X-Received: by 2002:a17:90a:2e82:b0:263:e814:5d0f with SMTP id r2-20020a17090a2e8200b00263e8145d0fmr10758225pjd.41.1688917354214;
        Sun, 09 Jul 2023 08:42:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGsEg78pL43U82H6CgYr3QEPQ95eRNBYMptmzATWoIDcYOp+ZNDxNuLrDhBOrn8grnrP2mD7D2In1uL+SWZ4VI=
X-Received: by 2002:a17:90a:2e82:b0:263:e814:5d0f with SMTP id
 r2-20020a17090a2e8200b00263e8145d0fmr10758218pjd.41.1688917353874; Sun, 09
 Jul 2023 08:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230703162509.77828-1-koba.ko@canonical.com> <4ec2b7d2-11a5-6ab6-087a-175ed31faca4@web.de>
 <SJ1PR11MB60839A0FC6B5E79E3E5A7997FC29A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+UB+eYoYOOVH2bqnnVEJcLrxaj5A7-zyfgBM7hOf4y8zw@mail.gmail.com>
 <SJ1PR11MB608383A5841E4AE8D3A64B79FC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+VFYyTiQ7yhX=Z8-Q4QW-GMsGXMuEWxLjuoZ1aDB98qXg@mail.gmail.com>
 <SJ1PR11MB60832C7FFEF98EE33F255B9DFC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CY8PR11MB713495A12DE47EDC3B7C5E20892CA@CY8PR11MB7134.namprd11.prod.outlook.com>
 <CAJB-X+X_KW=T4WOe2AS3SFFQKjt7VcQRFUCGYFcjipi5-aXdrw@mail.gmail.com> <CY8PR11MB71346D8945AAC57D3614CBE2892DA@CY8PR11MB7134.namprd11.prod.outlook.com>
In-Reply-To: <CY8PR11MB71346D8945AAC57D3614CBE2892DA@CY8PR11MB7134.namprd11.prod.outlook.com>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Sun, 9 Jul 2023 23:42:22 +0800
Message-ID: <CAJB-X+Xe9H0O=-2o3hL+pz=aGdSRYX+hD0bAxUS11CZDRVZLKg@mail.gmail.com>
Subject: Re: [PATCH v2] EDAC/i10nm: shift exponent is negative
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jul 7, 2023 at 11:34=E2=80=AFAM Zhuo, Qiuxu <qiuxu.zhuo@intel.com> =
wrote:
>
> > From: Koba Ko <koba.ko@canonical.com>
> > Sent: Friday, July 7, 2023 1:41 AM
> > To: Zhuo, Qiuxu <qiuxu.zhuo@intel.com>
> > ...
> > > I made a patch below to skip all these absent memory controllers
> > > https://lore.kernel.org/linux-edac/20230706134216.37044-1-qiuxu.zhuo@=
i
> > > ntel.com/T/#u @Koba Ko, could you please verify the patch from the
> > > link above on your workstation? Thanks!
> >
> > Here's dmesg patched(Ref. 1). didn't find the previous message, `EDAC
> > DEBUG: skx_get_dimm_attr: bad ranks =3D 3 (raw=3D0xffffffff)`
> >
> > Ref. 1,
> > https://drive.google.com/drive/folders/1xym9JgZZgaJ3EqtP4ccRcVeQYoJKmV
> > lp?usp=3Dsharing
>
> Thanks for the verification.
> Your log showed that the patch worked well.

please,
tested-by: koba.ko@canonical.com
>
> -Qiuxu
