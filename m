Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8988D207F11
	for <lists+linux-edac@lfdr.de>; Thu, 25 Jun 2020 00:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388217AbgFXWB5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 24 Jun 2020 18:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389832AbgFXWB4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 24 Jun 2020 18:01:56 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECC5C061573
        for <linux-edac@vger.kernel.org>; Wed, 24 Jun 2020 15:01:55 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t6so2143093pgq.1
        for <linux-edac@vger.kernel.org>; Wed, 24 Jun 2020 15:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=JtnqSIsBj/BF7IGUdXeNN8kYdqMgoQN65lThbV8+e0I=;
        b=rZelCg0YbzRPlv5V+vuWn7sHK13srbX1cO1mAPMUgY5O2vjHkTVamQ63cuzjEo1okr
         VGoq/xvgXtW3T7rM8FoDdrggIP/BCOiG/fcMJRE3z0VeakJmfqLp0FeDoqudgXv1QGM8
         UFGOCWRbR2wWAx6C7coZTrMeJ4kuXqKqNUr580acWMdtPZVJNA4fy7FYZ+XtCZW4P+pa
         Mm2w5QoqcmG4/HU8jywfTVydwWgqTeykuOz3lQJsuL6gxMj7TG8cZOFrieNwyBnFcgvN
         htocwK4LkAGiIufTQ49KIumINcO7+IqKdoTELynNMvsv30ZWFNSGphyTBqrD1pEOBpk9
         hmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=JtnqSIsBj/BF7IGUdXeNN8kYdqMgoQN65lThbV8+e0I=;
        b=tZSn6rA1+KUbOCGElRJD6iaDJ2WhxhRBEuk48LVeK/lvu8sXswwf811cYQ653qcrtX
         KCH6Wuo/SFXLXRtCGYtyRxy2qufZ4OXtK+7n/yiZ5TdWzGYUE8RsT0O5zhkQrK+8GOCa
         0foCOKTfsf/N/MU0hKRpBnlCzxXGtu7j9Da4uiU2fWmbAaRojS5y/NpYWJ6uP7G+tGNJ
         SOPIdT+375QBeLW+M5mLZSOp6f6fC9w+mAuCdBI/JajVYhOqs2Mj/vu0fvKnGUKU8AJu
         2aEk6zU4hTQcc6lAtvOOwu4Rp5DOCKXWh+l9qb5bm55sAbXl94v32OBmdWjrNmsV1b5J
         fz2g==
X-Gm-Message-State: AOAM531rYHYUzAGiAbYlJcbIsrG9euV2040pFg7eelD3oxVo5wcFTlD1
        vTT73froZgXKkvK/AaDkS312Rw==
X-Google-Smtp-Source: ABdhPJw0lsYH2vvdsw13COy6bxZEFzIg7Dt5qMmJFPNgfCeGO7YHrLsda6vxpHhbi8XYyIdvwHcfiA==
X-Received: by 2002:aa7:9105:: with SMTP id 5mr3283028pfh.199.1593036115064;
        Wed, 24 Jun 2020 15:01:55 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id u26sm7814361pgo.71.2020.06.24.15.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 15:01:54 -0700 (PDT)
Date:   Wed, 24 Jun 2020 15:01:53 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Jane Chu <jane.chu@oracle.com>
cc:     "Luck, Tony" <tony.luck@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-edac@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [RFC] Make the memory failure blast radius more precise
In-Reply-To: <19ffec14-28c7-fddc-3042-6ccb8d4e83fa@oracle.com>
Message-ID: <alpine.DEB.2.22.394.2006241459540.62172@chino.kir.corp.google.com>
References: <20200623201745.GG21350@casper.infradead.org> <20200623220412.GA21232@agluck-desk2.amr.corp.intel.com> <alpine.DEB.2.22.394.2006232114100.97817@chino.kir.corp.google.com> <19ffec14-28c7-fddc-3042-6ccb8d4e83fa@oracle.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, 24 Jun 2020, Jane Chu wrote:

> Hi, David,
> 
> On 6/23/2020 9:32 PM, David Rientjes wrote:
> > I don't want to hijack Matthew's thread which is primarily about DAX, but
> > did get intrigued by your concerns about hugetlbfs page poisoning.  We can
> > fork the thread off here to discuss only the hugetlb application of this
> > if it makes sense to you or you'd like to collaborate on it as well.
> 
> hugetlbfs is not supported in DAX, are you planning to add support?
> 

No, sorry, I was replying only about Tony's comment about the current page 
poisoning behavior for hugetlbfs and brainstorming a way that we could 
reduce the memory failure blast radius for hugetlb pages if we had the 
doublemap support that would also be useful for post-copy live migration.

It's independent of DAX so I'm happy to fork this topic off into a 
different thread for the hugetlb discussion.
