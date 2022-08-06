Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08E758B416
	for <lists+linux-edac@lfdr.de>; Sat,  6 Aug 2022 08:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiHFGpz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 6 Aug 2022 02:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiHFGpx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 6 Aug 2022 02:45:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E901409C;
        Fri,  5 Aug 2022 23:45:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M0Cf72ql6z4x1J;
        Sat,  6 Aug 2022 16:45:51 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>, linux-edac@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <993f5a7da371458cb819b5f3f569073c78523b01.1659436180.git.christophe.leroy@csgroup.eu>
References: <993f5a7da371458cb819b5f3f569073c78523b01.1659436180.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] EDAC/ppc_4xx: Include required of_irq header directly
Message-Id: <165976833020.1752861.6222110588738974430.b4-ty@ellerman.id.au>
Date:   Sat, 06 Aug 2022 16:45:30 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 2 Aug 2022 12:30:38 +0200, Christophe Leroy wrote:
> Commit 4d5c5bad5193 ("powerpc: Remove asm/prom.h from asm/mpc52xx.h
> and asm/pci.h") that cleans up powerpc's asm/prom.h leads to build
> errors in ppc4xx_edac.c due to missing header. Include required
> header directly to avoid the build failure.
> 
> 

Applied to powerpc/next.

[1/1] EDAC/ppc_4xx: Include required of_irq header directly
      https://git.kernel.org/powerpc/c/bce02f71e48f7b89b9b52424ad2df4e5bc87a8ec

cheers
