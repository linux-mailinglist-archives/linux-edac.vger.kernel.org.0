Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017E01389A6
	for <lists+linux-edac@lfdr.de>; Mon, 13 Jan 2020 04:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733020AbgAMDQN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 12 Jan 2020 22:16:13 -0500
Received: from mail02.vodafone.es ([217.130.24.81]:32541 "EHLO
        mail02.vodafone.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732961AbgAMDQN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 12 Jan 2020 22:16:13 -0500
IronPort-SDR: 9jXQvli93G038bW5LQlgV+8/I1eHsqwDFLwRIozqQ8c5Yw7sTYEUXhTKFG11pAXq3wdThW34Gf
 JFLxBkcKd2Gw==
IronPort-PHdr: =?us-ascii?q?9a23=3Ao/FunBOLwdGxcIc4RjUl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0IvX7rarrMEGX3/hxlliBBdydt6sfzbCI4uu9BiQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Ngu6oATVu8UZgYZvKLs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gysBMDI37X3YhdZ1jKNbuR6suRt/w5TMYIGSLvpxZL/dcs0DSW?=
 =?us-ascii?q?VfWMZdTjBMAp+gb4QVE+UBPfhXr4zjqFsIsRuyHBejBOX2xjFPgX/227M10u?=
 =?us-ascii?q?Q4HQ7Y2gwrAtYCvXrIoNnpMasfV/2+wqvVwjXZd/5Y1zfz6JLWfB4ivP+DUq?=
 =?us-ascii?q?5/f8XKxEkzFQ7KkkmcpZD5Mz+L0OkGrmiV7/BnVeKqk2MpsR9+oiSxycc2l4?=
 =?us-ascii?q?LGhoUVylbL9S5kx4s1PcO3SFJlbt6+HppQsCeaN4RtT8MiWGFnozo1xqcatp?=
 =?us-ascii?q?68eSgG0pQnxx3GZvGBboOG4QrjWf6PLTtlhn9pYq+zihiu/US61OHxWdO43V?=
 =?us-ascii?q?hKoydDj9LCrGoC1wbJ5ciCUvZ9+0Ch1iuR2A3L8eFEJFw0lbLcK5483r48jp?=
 =?us-ascii?q?oTvlrHHi/xgEj2ibWZdkQg+uiy9evnZqnqq5CGO49qjQHxL74hmsK4AeQ+LA?=
 =?us-ascii?q?cCRXaU+f+k2L3i+032XqlKg+UonqXEsp3WP9kXq6ClDwNPzIou5AyzAjmm3d?=
 =?us-ascii?q?gAmHkINlNFeBaJj4jzPFHOJej1De+hjFSwjjhr3f7HPrrnApXCNXXDkKzhcq?=
 =?us-ascii?q?1h5EJG1AUzytVf64hUCrECOP7zQFP+tMTEDh8lNAy52+LnCNR71oMDVmODG7?=
 =?us-ascii?q?GWP77IvlCU/e8vPeaMa5EPuDrnKPgq+eTujXknll8ZZ6Wp2oEXaH/rVshhdk?=
 =?us-ascii?q?GYZ2f8x9oNGGwioAUzVqrphUeEXDoVYGy9DJgx/jUqNIXzNYrfS5rlv7uH02?=
 =?us-ascii?q?/vBpBKa3pZDVaDEXTobI+Pc/gJYSOWZMRml2pXe6KmTtoZ2A2jrkfFzLxoZr?=
 =?us-ascii?q?7M9zEVr43k0tdd5/bZnlc58jkyD8fLgDLFdH19gm5dHmx+56t4u0EokQ/b3A?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GUIwDU3xtemCMYgtlNGBoBAQEBAQE?=
 =?us-ascii?q?BAQEDAQEBAREBAQECAgEBAQGBewIBGAEBgS6BTVIgEpNQgU0fg0OLY4EAgx4?=
 =?us-ascii?q?VhggTDIFbDQEBAQEBNQIBAYRATgEXgQ8kOgQNAgMNAQEFAQEBAQEFBAEBAhA?=
 =?us-ascii?q?BAQEBAQYNCwYphUqCHQweAQQBAQEBAwMDAQEMAYNdBxkPOUpMAQ4BU4MEgks?=
 =?us-ascii?q?BATOcbwGNBA0NAoUdgkoECoEJgRojgTYBjBgagUE/gSMhgisIAYIBgn8BEgF?=
 =?us-ascii?q?sgkiCWQSNQhIhgQeIKZgXgkEEdolMjAKCNwEPiAGEMQMQgkUPgQmIA4ROgX2?=
 =?us-ascii?q?jN1eBDA16cTMagiYagSBPGA2IG44tQIEWEAJPiS6CMgEB?=
X-IPAS-Result: =?us-ascii?q?A2GUIwDU3xtemCMYgtlNGBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBewIBGAEBgS6BTVIgEpNQgU0fg0OLY4EAgx4VhggTDIFbDQEBA?=
 =?us-ascii?q?QEBNQIBAYRATgEXgQ8kOgQNAgMNAQEFAQEBAQEFBAEBAhABAQEBAQYNCwYph?=
 =?us-ascii?q?UqCHQweAQQBAQEBAwMDAQEMAYNdBxkPOUpMAQ4BU4MEgksBATOcbwGNBA0NA?=
 =?us-ascii?q?oUdgkoECoEJgRojgTYBjBgagUE/gSMhgisIAYIBgn8BEgFsgkiCWQSNQhIhg?=
 =?us-ascii?q?QeIKZgXgkEEdolMjAKCNwEPiAGEMQMQgkUPgQmIA4ROgX2jN1eBDA16cTMag?=
 =?us-ascii?q?iYagSBPGA2IG44tQIEWEAJPiS6CMgEB?=
X-IronPort-AV: E=Sophos;i="5.69,427,1571695200"; 
   d="scan'208";a="323716499"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail02.vodafone.es with ESMTP; 13 Jan 2020 04:16:12 +0100
Received: (qmail 24144 invoked from network); 12 Jan 2020 05:00:19 -0000
Received: from unknown (HELO 192.168.1.3) (quesosbelda@[217.217.179.17])
          (envelope-sender <peterwong@hsbc.com.hk>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-edac@vger.kernel.org>; 12 Jan 2020 05:00:19 -0000
Date:   Sun, 12 Jan 2020 06:00:18 +0100 (CET)
From:   Peter Wong <peterwong@hsbc.com.hk>
Reply-To: Peter Wong <peterwonghkhsbc@gmail.com>
To:     linux-edac@vger.kernel.org
Message-ID: <29286417.460703.1578805219465.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Greetings,
Please read the attached investment proposal and reply for more details.
Are you interested in loan?
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

