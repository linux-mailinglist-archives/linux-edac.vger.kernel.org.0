Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452007DD700
	for <lists+linux-edac@lfdr.de>; Tue, 31 Oct 2023 21:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjJaUVH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 31 Oct 2023 16:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjJaUVG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 31 Oct 2023 16:21:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FF7F5
        for <linux-edac@vger.kernel.org>; Tue, 31 Oct 2023 13:21:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF8EC433C8;
        Tue, 31 Oct 2023 20:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698783664;
        bh=TvAgpXNrBsDbGUYXMUKr4xV7wGchv/iAZ+BL6x9vO7g=;
        h=Date:From:To:Subject:From;
        b=FA2iCzIsaBJxIkr0ie5NG2u00l3Y/VVIRybcLdNbwd2zIQ5Y101/56Apt6FgNEuxa
         kSOAV4gTsDYNgOTNVq2v607d8srJM9mowy8U/OcGxMVAzRLqLtXfhN0cm/so+w2qSF
         nexnmxpKKTb7Se0veTXtI5xx5i7rzRTnydHh4Cj0=
Date:   Tue, 31 Oct 2023 16:21:03 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     linux-edac@vger.kernel.org
Subject: PSA: migrating linux-edac to new vger infrastructure
Message-ID: <20231031-buffalo-of-eternal-felicity-90dca2@nitro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Good day!

I plan to migrate the linux-edac@vger.kernel.org list to the new
infrastructure this week. We're still doing it list-by-list to make sure that
we don't run into scaling issues with the new infra.

The migration will be performed live and should not require any downtime.
There will be no changes to how anyone interacts with the list after
migration is completed, so no action is required on anyone's part.

Please let me know if you have any concerns.

Best wishes,
-K
