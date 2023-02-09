Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B0D690BA6
	for <lists+linux-edac@lfdr.de>; Thu,  9 Feb 2023 15:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjBIOZb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 Feb 2023 09:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjBIOZb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 9 Feb 2023 09:25:31 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288F8CC17;
        Thu,  9 Feb 2023 06:25:28 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5430D1EC06C0;
        Thu,  9 Feb 2023 15:25:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675952726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hwcLQfgKK1YCRdup7YjOPgCaSkfIVY6um1QD8hgRlcs=;
        b=ciD901jIszV+n6y1q1q1YxRiz8DRgs66u1YsKD8+YN8qg32RMhJuMbRD9oMxF+ZeESlq4p
        +rMrHoVY1giyNnmgQ43RticVhpkuj/g8ka71u438lC2H15PudEH8/FyCFPCs8IA1HwTobn
        4LGKqwC8tItYFmXBXi4UwffhLjl+b7w=
Date:   Thu, 9 Feb 2023 15:25:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        muralidhara.mk@amd.com, naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH v2 06/22] EDAC/amd64: Rename debug_display_dimm_sizes()
Message-ID: <Y+UCT9GizQYGRGYb@zn.tnic>
References: <20230127170419.1824692-1-yazen.ghannam@amd.com>
 <20230127170419.1824692-7-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230127170419.1824692-7-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 27, 2023 at 05:04:03PM +0000, Yazen Ghannam wrote:
> Use the "dct" and "umc" prefixes for legacy and modern versions
> respectively.
> 
> Also, move the "dct" version to avoid a forward declaration, and fixup
> some checkpatch warnings in the process.

Yeah, but it is hard to review a move and changes in a single patch.
Pls split it into

1. Mechanical move only
2. Other changes

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
