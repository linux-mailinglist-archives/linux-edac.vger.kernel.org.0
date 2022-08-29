Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6155A4199
	for <lists+linux-edac@lfdr.de>; Mon, 29 Aug 2022 05:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiH2DxK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 28 Aug 2022 23:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiH2DxA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 28 Aug 2022 23:53:00 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E138141D1E;
        Sun, 28 Aug 2022 20:52:54 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t5so8550738edc.11;
        Sun, 28 Aug 2022 20:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=i3P9yvcZ5w9JMjlHaA5/F93BbKF3hEM1ahs4PE9M3sU=;
        b=EbOKh9LMbPDhquOkY6YMTz7GEGWR8BQdmUe/hFPRalUfSmCBlFoBUeVaRDfwPdTYaV
         tW0Ke+svFy/1TG35d4XkmsssGORHSWaWeQSJGYLARCGoyZekbQVmVCzkyKsJUs8Kbz50
         13OVjkFXLZiHB/zBnBRgwyiBwb0DGcWicq0vxESy5yojgC5M+ig19TPHSHLQZ5BOVW98
         i5XBk/IOxwBBpBz6cQ2j/GDO00HBpM/Z7aWO8iJ4mTvN2IJb+bzs/m9cKSr8hDXeC9eK
         1jihznrGnU21jYVBlVrhl/WnVScOON0o8Yd2PtBg7CqNE70hpQn1y4ifwYZVvYXVRe9e
         +3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=i3P9yvcZ5w9JMjlHaA5/F93BbKF3hEM1ahs4PE9M3sU=;
        b=mP+WqKAiyyRLkNZzfG9CZArEOrfRG2oxXBLICbvKwGwg20K57h/hgsBDY0CBtJmwbl
         91dRgnsUNG/n3rdvLeOMR/vyXWqxR9+ac7FgFwmI6MF/j2LsI0T/gw6ZONYV1uyV77pF
         sAAghFseIsL/4uFQs/gjtds9powQ/dQd8DM6qhydxUvimiv2P0GrP8lMidset/DeBPko
         b/wBGLDL7VT+49LxjICeQRzPh0R6fDdo7V9sv+1XoZy+Bppssh7wJkWUUltr+wHlTgyb
         t3dDXPPpJIZdiI/wE6tdbSgJZF5xqtCb9xratjma7O9yMlXuNRrtjAOC05tLVatqMfZU
         TofA==
X-Gm-Message-State: ACgBeo1ZT9v99jXZeQuQea/YM1yWZoQqWcf7iSgsSEsBqjkFQHVMddre
        K0PYpAQu8QGTvFDe+b39VQzNFBfoTH9G9tB3CYw=
X-Google-Smtp-Source: AA6agR7gHwwO7J0rRiChvfQJve8VQ06faGb/93y5NKqE+1wlyC2GzzLvQxic3/P0jIdT/P1vktF+OzV/JS5XKJ3fcFI=
X-Received: by 2002:a05:6402:34cd:b0:448:8286:23f0 with SMTP id
 w13-20020a05640234cd00b00448828623f0mr1259550edc.40.1661745173471; Sun, 28
 Aug 2022 20:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220816094641.8484-1-milkfafa@gmail.com> <20220816094641.8484-3-milkfafa@gmail.com>
 <20220818144442.GB1829017-robh@kernel.org>
In-Reply-To: <20220818144442.GB1829017-robh@kernel.org>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Mon, 29 Aug 2022 11:52:42 +0800
Message-ID: <CADnNmFqPmr7Af1ROALPbfoj73p5d1bKjhYV+MuO9KhCQMk=FAQ@mail.gmail.com>
Subject: Re: [PATCH v13 2/3] dt-bindings: edac: nuvoton: Add document for NPCM
 memory controller
To:     Rob Herring <robh@kernel.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>, rric@kernel.org,
        James Morse <james.morse@arm.com>, tony.luck@intel.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        CS20 KWLiu <KWLIU@nuvoton.com>, YSCHU@nuvoton.com,
        Benjamin Fair <benjaminfair@google.com>,
        devicetree <devicetree@vger.kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Patrick Venture <venture@google.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        KFTING <KFTING@nuvoton.com>, JJLIU0@nuvoton.com,
        Tali Perry <tali.perry1@gmail.com>, ctcchien@nuvoton.com,
        Marvin Lin <kflin@nuvoton.com>,
        Tomer Maimon <tmaimon77@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Rob,

Thanks for the review.

Regards,
Marvin
