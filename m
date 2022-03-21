Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D694E2418
	for <lists+linux-edac@lfdr.de>; Mon, 21 Mar 2022 11:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346079AbiCUKRg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 21 Mar 2022 06:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346225AbiCUKRf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 21 Mar 2022 06:17:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FA9986F0;
        Mon, 21 Mar 2022 03:16:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EF3D6210EC;
        Mon, 21 Mar 2022 10:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647857765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xvcSTlU5vKYFbBNHotaZrVuLA/p3fs8kSntrwRk3fk0=;
        b=Zthas33+nHSZJ5CTxv7FyJg2z5QChe2SajEwqtWVuKS7loPcH/vWAeQxojWavIpToWOJfw
        87Q97Kut2MSqcLOOKpu5Pwapa7zKljZV2Oj0AOWL/9tTbw1Pn0q3NsmLmNx443TVt28iWD
        eQj1YNq1zDfEmBG1RRAkOvTxkkyLEQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647857765;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xvcSTlU5vKYFbBNHotaZrVuLA/p3fs8kSntrwRk3fk0=;
        b=wPGcoGPteEi4YsUOyPrckTew+BIG39p9f3Xqw+giYOl9HjPF8R/3qvs+hkyCvxjtfg+iCV
        zn8rgWcSgS5MflDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF34E13AD5;
        Mon, 21 Mar 2022 10:16:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7FF6NmVQOGLFdAAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 21 Mar 2022 10:16:05 +0000
Date:   Mon, 21 Mar 2022 11:16:01 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for 5.18
Message-ID: <YjhQYeGqsuiXAsSp@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

please pull the small pile of EDAC updates accumulated in the last
round.

Thx.

---

The following changes since commit cfb92440ee71adcc2105b0890bb01ac3cddb8507:

  Linux 5.17-rc5 (2022-02-20 13:07:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v5.18_rc1

for you to fetch changes up to 1422df58e5eb83dca131dc64e0f307a1f9e56078:

  Merge branch 'edac-amd64' into edac-updates-for-v5.18 (2022-03-21 10:34:57 +0100)

----------------------------------------------------------------
- Add support for newer AMD family 0x19, models 0x10-... CPUs to amd64_edac

- The usual amount of improvements and fixes

----------------------------------------------------------------
Borislav Petkov (1):
      Merge branch 'edac-amd64' into edac-updates-for-v5.18

Eliav Farber (1):
      EDAC/mc: Remove unnecessary cast to char * in edac_align_ptr()

Greg Kroah-Hartman (2):
      EDAC: Use proper list of struct attribute for attributes
      EDAC: Use default_groups in kobj_type

Rabara Niravkumar L (1):
      EDAC/altera: Add SDRAM ECC check for U-Boot

Yazen Ghannam (2):
      EDAC/amd64: Set memory type per DIMM
      EDAC/amd64: Add new register offset support and related changes

 drivers/edac/altera_edac.c       |  40 +++++++++++++-
 drivers/edac/amd64_edac.c        | 109 +++++++++++++++++++++++++++++++--------
 drivers/edac/amd64_edac.h        |  24 ++++++++-
 drivers/edac/edac_device_sysfs.c |  31 ++++++-----
 drivers/edac/edac_mc.c           |   4 +-
 drivers/edac/edac_pci_sysfs.c    |  26 +++++-----
 6 files changed, 183 insertions(+), 51 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
