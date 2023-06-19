Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3595F73557C
	for <lists+linux-edac@lfdr.de>; Mon, 19 Jun 2023 13:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjFSLHo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Jun 2023 07:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjFSLHf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 19 Jun 2023 07:07:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C53FA;
        Mon, 19 Jun 2023 04:07:24 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5AA611EC0978;
        Mon, 19 Jun 2023 13:07:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687172843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=AzXBLSMUzdGSpkuYbpw2n9gPhEv7jeKEK0oheqBR6v0=;
        b=bbd+4OCrcTzzN7ewtXwwg7eMas3ODEG4qxC0Enu5OFPzZdD5IDaZqWsoFmTvOyThzLZnD2
        gG0SEQGmVM0DSsib6NCafWcv33AplxtxwKdxO+MfX4M5nJoMdp0/QTgNIyNsjOqd94WkW0
        kTzKeZzXB+2EBxi2F4fxpHOlinnJVnQ=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CIGfTPVhJV9s; Mon, 19 Jun 2023 11:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687172841; bh=AzXBLSMUzdGSpkuYbpw2n9gPhEv7jeKEK0oheqBR6v0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cbrzuFfU4W66bUfpIKucnaoi414Jg/WJ+Qa6KWBdzfSbdtvPJ488p/eCFvxDxL1Mo
         CZKTIVUxY4LWn5GbeCGnmd/+hXpqHpdGvpP/TosdcSYRQK5HlEsK2m4JvkM8YNF5Op
         pc8SpYCU9VHmhYlH4f7cfmzM8YkxQceaAodyAAMg+MKGaypW/+VtoQ0V6B0oqKVxqi
         qLtZAooqzxr2+OnJhqkCYUPnruIO3HHXJy+ZfdLZWEQGr58D0jLqtmLKxh4H8zIiON
         n4+BHmYJvBuLbyrHJo73dNvUK8cKEvGdddnQ8D6xKdVbVxpO/98ti5Pzen7KTXYdAH
         TyNUg6tAKqeVcJFRlIrVm/COP/m671kd9dVmHUJQA1QBTr7KmmXL9Ii/+dAhn0ne2l
         bGDUV7aYIlO9ovheO5WK5dRMgWTX/VSPNsK1H4A+M0Av2bFPgw9r+ySsxvHAyOHoDz
         CqoDGEiHAffHdcfZUnigr9FXJ9rpwnDe+N91dA1328auDDaWvb34IoGBxRxFKNkv+n
         MKPs51Cqw4JkDkS18zWkIdN9uFGiXuB3LoU8kxi/athrf0k0k0i7SSyVSD04ICS0pI
         ATui8664uksDNBnrCsv0cB8er1fMpo/5ambr4CjQJ+D4XrMVF4xxY90peQ51mT9Lg0
         SGdwyzfzdt9NikJEj76iCDKQ=
Received: from zn.tnic (p200300eA971Dc5d9329C23FffEA6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c5d9:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 088D540E01D0;
        Mon, 19 Jun 2023 11:07:12 +0000 (UTC)
Date:   Mon, 19 Jun 2023 13:07:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Tom Rix <trix@redhat.com>, tony.luck@intel.com,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd64: set variable gpu_node_map
 storage-class-specifier to static
Message-ID: <20230619110704.GAZJA22FpkwY108vUh@fat_crate.local>
References: <20230610210930.174074-1-trix@redhat.com>
 <89a67e4d-cada-ff57-f702-d5579ea8b39c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89a67e4d-cada-ff57-f702-d5579ea8b39c@amd.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 14, 2023 at 11:21:46AM -0400, Yazen Ghannam wrote:
> Also, would a Fixes tag be appropriate?

No need. I've squashed this with the topmost commit in tip:ras/core
which introduced gpu_node_map in the first place.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
