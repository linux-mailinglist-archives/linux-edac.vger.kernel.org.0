Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFA74E30BB
	for <lists+linux-edac@lfdr.de>; Mon, 21 Mar 2022 20:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352724AbiCUTUM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 21 Mar 2022 15:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352687AbiCUTUD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 21 Mar 2022 15:20:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EBF1AF0C;
        Mon, 21 Mar 2022 12:18:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C3FDB819C1;
        Mon, 21 Mar 2022 19:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5611C340F2;
        Mon, 21 Mar 2022 19:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647890313;
        bh=QRocsnvANgRqKNdeAnUxjWNYR7MTrU7rvVXELF2n/7g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LhGX7v1MlzNnf59vfDnpEDwAGCCTnwm6ghRYxxr/EMRJmhBFb1wAm42+gOdTXfoSI
         Yua/pRxZMwq2AGh/Qc+Cwccv8wjpKd9tagjJlxd/kntw87SfYlyxnm2GGz8DnvEHX6
         StFpigkierTdHbOKRGB3p42dUFqXq1OncVRX07oh0HldzX/bnk/JT9UMiRl6dQcgJ8
         paqmECgyN4/6DfIORw6rUZ+r/ROFNpNBq9YCA8EoFSU6I9lnXMRrmhwOBiI1kRdMBb
         3QwhO/wHA4nRIN/Ez6L4FA0U6cc2fHrF+QXzRqCz08/Fh983elgNLjHwHGZoEwokJ2
         XacPlNtK11VcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE0A1E7BB0B;
        Mon, 21 Mar 2022 19:18:33 +0000 (UTC)
Subject: Re: [GIT PULL] EDAC updates for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YjhQYeGqsuiXAsSp@zn.tnic>
References: <YjhQYeGqsuiXAsSp@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YjhQYeGqsuiXAsSp@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v5.18_rc1
X-PR-Tracked-Commit-Id: 1422df58e5eb83dca131dc64e0f307a1f9e56078
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e8919170ad683436a1a1305e1795dc1d56f8906
Message-Id: <164789031370.24158.12305290548070250476.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Mar 2022 19:18:33 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 11:16:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v5.18_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e8919170ad683436a1a1305e1795dc1d56f8906

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
