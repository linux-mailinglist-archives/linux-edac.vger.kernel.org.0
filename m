Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4E157FF58
	for <lists+linux-edac@lfdr.de>; Mon, 25 Jul 2022 14:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiGYMzE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Jul 2022 08:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiGYMzD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 25 Jul 2022 08:55:03 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BF165B9;
        Mon, 25 Jul 2022 05:55:02 -0700 (PDT)
Received: from zn.tnic (p200300ea972976f8329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9729:76f8:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 246271EC066B;
        Mon, 25 Jul 2022 14:54:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658753697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XZTLkEqoFkzzor3WyMU+RQL/cgbQg2rQ/fr2JtF2QBw=;
        b=Qco5aSJdY7/NsLkQFAvCH/csrV62Umb/gvg2iNkWbtjHBtiqeFnDsS2T7TiSotzHE9aFjF
        C1Vh2kn72Ao7coMZrRENAc2OSxxf9RFY2W76cEaOreAv+DF3rDBnuSsnFOzrLObq4ocCtM
        KRCVHHeFCrvTkbHC4S4pcL1YNAO46Y4=
Date:   Mon, 25 Jul 2022 14:54:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rric@kernel.org>
Cc:     Toshi Kani <toshi.kani@hpe.com>, mchehab@kernel.org,
        elliott@hpe.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/ghes: Fix buffer overflow in ghes_edac_register()
Message-ID: <Yt6SoF7KTunG+Ls6@zn.tnic>
References: <20220721180503.896050-1-toshi.kani@hpe.com>
 <YtqkMicKdZdPdUWB@zn.tnic>
 <Yt5oAjbZ5Koy9v5i@rric.localdomain>
 <Yt5s/f/jyRcFY1Md@zn.tnic>
 <Yt50Pp3kQRCtSqw6@rric.localdomain>
 <Yt5510+uLKzv+Qvt@rric.localdomain>
 <Yt59LiHs3gWNpNW1@zn.tnic>
 <Yt5+4feA3Qux743w@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yt5+4feA3Qux743w@rric.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jul 25, 2022 at 01:30:41PM +0200, Robert Richter wrote:
> If you like, you can add my:
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Do you mean by this Co-developed-by: perhaps?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
